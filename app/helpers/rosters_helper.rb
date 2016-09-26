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
    when 'paid_holiday' # 有休
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
    r.total_hour_working.to_f + r.total_hour_house.to_f +
    (r.bereavement.to_f + r.home.to_f + r.special.to_f + r.drill.to_f) * Roster::BASE_WORK_HOUR
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
    ah = required_work_hour(r) - total_target_liquidation_hour(r)
    return ah < 0.0 ? ah : 0.0
  end

  # 有休残日数計算
  def rest_paid_leave(r)
    # 年毎のユーザー付随情報
    info = r.user.info_for_each_fiscal_years

    # 初めて有休が付与された日付
    grant_date_of_paid_leave = r.user.grant_date_of_paid_leave

    # 有休日数算出のた為に集計を開始する年月を抽出
    period_month = grant_date_of_paid_leave.month #.to_s.rjust(2, '0')

    carry_over_paid_leave_count = 0.0 # 持ち越し有休日数
    carry_over_late_ealy = 0.0 # 持ち越し遅刻早退
    target_rosters = r.user.rosters

    # 付与月を越えていれば当年度だけ抽出
    if period_month.to_s.rjust(2, '0') < r.month
      target_rosters = target_rosters.where(year: r.year, month: (period_month..(r.month.to_i)).to_a.map{ |m| m.to_s.rjust(2, '0') }).to_a
      info = info.where(year: r.year).first
    else
      target_rosters = target_rosters.where(year: r.year, month: (1..(r.month.to_i)).map{ |m| m.to_s.rjust(2, '0') }).to_a
      # 前年度の勤務表も抽出
      previous_rosters = r.user.rosters.where(year: (r.year.to_i - 1).to_s, month: [period_month..12].map{ |m| m.to_s.rjust(2, '0') }).to_a
      target_rosters.concat(previous_rosters)

      info = info.where(year: (r.year.to_i - 1).to_s).first
    end

    # ユーザーに付随する年度毎の情報がなければReturn
    return 0.0 if info.blank?

    # 繰越越し有休日数
    carry_over_paid_leave_count = info.carry_over_paid_leave_count.to_f
    # 繰越し遅刻早退
    carry_over_late_ealy = info.carry_over_late_ealy.to_f

    total_late_early = 0.0
    rest_paid_leave_count = carry_over_paid_leave_count
    target_rosters.map { |rs|
      total_late_early += rs.total_hour_late_early.to_f
      rest_paid_leave_count -= rs.paid_holiday.to_f
    }
    total_late_early = total_late_early + carry_over_late_ealy
    # トータルの遅刻早退が4hを越えた場合、有休が0.5減る計算
    rest_paid_leave_count = rest_paid_leave_count - ((total_late_early / 4).to_i * 0.5)
    rest_paid_leave_count + get_paid_leave(r)
  end

private

  # 有休付与月ならばその日数を返却する
  def get_paid_leave(r)
    # 初めて有休が付与された日付
    grant_date_of_paid_leave = r.user.grant_date_of_paid_leave

    month_roster = r.month.to_i
    mont_grant_date_of_paid_leave = grant_date_of_paid_leave.month

    if mont_grant_date_of_paid_leave == month_roster
      year_grant_date_of_paid_leave = grant_date_of_paid_leave.year.to_f
      year_roster = r.year.to_f

      # 経過年数分＋1日＋10日が付与される
      elapsed_years = year_roster - year_grant_date_of_paid_leave
      days_granted = (elapsed_years > 10.0) ? 10.0 : elapsed_years
      return days_granted + 10.0
    else
      return 0.0
    end
  end
end
