module RostersHelper
  def situation_select_options(one_day)
    if one_day.work_day?
      @work_day_options ||= OneDay::SITUASIONS.except(*OneDay::HOLIDAY_SITUATION_VALUE_LIST).invert
    else
      @holiday_options ||= OneDay::SITUASIONS.slice(*OneDay::HOLIDAY_SITUATION_VALUE_LIST).invert
    end
  end

  def td_class_for_background_color(one_day)
    # bootstrapのclass指定
    case one_day.situation
    when 'holiday' # 休日
      'warning'
    when 'paid_holiday' # 有給
      'info'
    else
      'normal'
    end
  end

  # 要出勤時間
  def required_work_hour(r)
    r.required_work_day.to_f * Roster::BASE_WORK_HOUR
  end

  # 精算対象時間
  def total_target_liquidation_hour(r)
    r.total_hour_working.to_f + 
    r.total_hour_house.to_f +
    r.total_hour_late_early.to_f +
    (r.paid_holiday.to_f + r.bereavement.to_f + r.home.to_f + r.special.to_f + r.drill.to_f) * Roster::BASE_WORK_HOUR
  end
  
  # 精算基本時間
  def total_base_liquidation_hour(r)
    r.allowance_hour.to_f + r.required_work_day.to_f * Roster::BASE_WORK_HOUR
  end

  # 精算時間
  def liquidation_hour(r)
    lh = total_target_liquidation_hour(r) - total_base_liquidation_hour(r)
    return lh > 0.0 ? lh : 0.0
  end
  
  # 調整時間
  def adjustment_hour(r)
    ah = total_target_liquidation_hour(r) - required_work_hour(r)
    return ah < 0.0 ? ah : 0.0
  end

  # 有給残日数計算
  def rest_paid_leave(r)
    # 有給日数算出の為に集計を開始する年月を抽出
    period_month = r.user.grant_date_of_paid_leave.month
    # 有給算出対象の勤務表を取得
    target_rosters = get_target_rosters(r, period_month)
    # 繰越[有給日数、遅早退時間]情報取得
    info = get_info(r, period_month)
    # 繰越越し有給日数
    carry_over_paid_leave_count = info.carry_over_paid_leave_count.to_f
    # 繰越し遅刻早退
    carry_over_late_ealy = info.carry_over_late_ealy.to_f

    total_late_early = get_total_late_early(target_rosters) + carry_over_late_ealy
    rest_paid_leave_count = carry_over_paid_leave_count - get_rest_paid_leave_count(target_rosters)

    # トータルの遅刻早退が4hを越えた場合、有給が0.5減る計算
    rest_paid_leave_count = rest_paid_leave_count - ((total_late_early / 4).to_i * 0.5)
    # 有給付与月の場合にプラスされる「get_paid_leave」
    rest_paid_leave_count += get_paid_leave(r)

    # 有給付与月には繰越情報を作成 or 更新
    if period_month == r.month.to_i
      carry_over_paid_leave_count = rest_paid_leave_count + ((total_late_early / 4).to_i * 0.5) + r.paid_holiday.to_f
      carry_over_late_ealy = total_late_early - r.total_hour_late_early.to_f

      while(true) do
        if carry_over_late_ealy < 0.0
          carry_over_paid_leave_count += 0.5
          carry_over_late_ealy += 4.0
        elsif carry_over_late_ealy >= 4.0
          carry_over_paid_leave_count -= ((carry_over_late_ealy / 4).to_i * 0.5)
          carry_over_late_ealy = (carry_over_late_ealy % 4.0)
        else
          break
        end
      end

      if carry_over_paid_leave_count > 20.0
        carry_over_paid_leave_count = 20.0
        carry_over_late_ealy -= ((carry_over_paid_leave_count - 20.0) * 8.0)
        if carry_over_late_ealy <= 0.0
          carry_over_late_ealy = 0.0
        end 
      end

      infos = r.user.info_for_each_fiscal_years
      info = infos.where(year: r.year).first

      if info.present?
        info.carry_over_paid_leave_count = carry_over_paid_leave_count
        info.carry_over_late_ealy = carry_over_late_ealy
        info.save
      else
        infos.create(company: r.user.company, year: r.year, carry_over_paid_leave_count: carry_over_paid_leave_count, carry_over_late_ealy: carry_over_late_ealy)
      end
    end
    
    return rest_paid_leave_count

  end

  private

  # 有給計算対象の勤務表を抽出
  def get_target_rosters(r, period_month)
    # 付与月を越えていれば当年度の勤務表だけを抽出
    if r.year.to_s + period_month.to_s.rjust(2, '0') < r.year + r.month
      target_rosters = r.user.rosters.where(year: r.year, month: (period_month..(r.month.to_i)).to_a.map{ |m| m.to_s.rjust(2, '0') }).to_a
    else
      target_rosters = r.user.rosters.where(year: r.year, month: (1..(r.month.to_i)).map{ |m| m.to_s.rjust(2, '0') }).to_a
      # 前年度の勤務表も抽出
      previous_rosters = r.user.rosters.where(year: (r.year.to_i - 1).to_s, month: (period_month..12).map{ |m| m.to_s.rjust(2, '0') }).to_a
      target_rosters.concat(previous_rosters)
    end
    
    return target_rosters
  end
  
  # 有給計算対象である勤務表の「遅早時間」取得
  def get_total_late_early(target_rosters)
    total_late_early = 0.0
    target_rosters.map { |rs|
      total_late_early += rs.total_hour_late_early.to_f
    }

    return total_late_early
  end
  
  # 有給計算対象である勤務表の「有給日数」取得
  def get_rest_paid_leave_count(target_rosters)
    rest_paid_leave_count = 0.0
    target_rosters.map { |rs|
      rest_paid_leave_count += rs.paid_holiday.to_f
    }

    return rest_paid_leave_count
  end

  # 繰越遅刻早退時間を取得
  def get_info(r, period_month)
    infos = r.user.info_for_each_fiscal_years

    # 付与月を越えていれば当年度の勤務表だけを抽出
    if period_month.to_s.rjust(2, '0') < r.month
      info = infos.where(year: (r.year.to_i).to_s).first
    else
      info = infos.where(year: (r.year.to_i - 1).to_s).first
      # ユーザーに付随する年度毎の情報がなければ
      if info.blank?
        # 前月分の勤務表を取り出し
        info = r.user.info_for_each_fiscal_years
                     .create(company: r.user.company, year: (r.year.to_i - 1).to_s, carry_over_paid_leave_count: 0.0, carry_over_late_ealy: 0.0)
      end
    end

    return info
  end
  
  # 有給付与月ならばその日数を返却する
  def get_paid_leave(r)
    # 初めて有給が付与された日付
    grant_date_of_paid_leave = r.user.grant_date_of_paid_leave

    month_roster = r.month.to_i
    month_grant_date_of_paid_leave = grant_date_of_paid_leave.month

    # 有給付与月判定
    if month_grant_date_of_paid_leave == month_roster
      year_grant_date_of_paid_leave = grant_date_of_paid_leave.year.to_f
      year_roster = r.year.to_f

      # 経過年数
      elapsed_years = year_roster - year_grant_date_of_paid_leave
      # 2017年度から有給付与日数を社内規程に合わせる
      days_granted = 10.0
      if year_roster.to_i > 2016
        if elapsed_years >= 3.0
          days_granted += (elapsed_years - 2.0) * 2 + 2
        else
          days_granted += elapsed_years
        end
      else
        days_granted += elapsed_years
      end

      # (経過年数分＋α)＋1日＋10日が付与される
      days_granted = (days_granted > 20.0) ? 20.0 : days_granted
      return days_granted
    else
      return 0.0
    end
  end
end
