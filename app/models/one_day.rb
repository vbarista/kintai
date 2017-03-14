# == Schema Information
#
# Table name: one_days
#
#  id            :integer          not null, primary key
#  roster_id     :integer
#  company_id    :integer
#  situation     :string
#  day           :date
#  from          :string(5)
#  to            :string(5)
#  working_hours :float
#  late_early    :string(5)
#  house         :string(5)
#  note          :string(256)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class OneDay < ActiveRecord::Base
  belongs_to :roster
  belongs_to :company

  SITUASIONS = {
                holiday:       '休暇',
                holiday_work:  '休出',
                work:          '出勤',
                paid_holiday:  '有給',
                late_early:    '遅早',
                transfer:      '振休',
                bereavement:   '忌引',
                special:       '特別',
                business_trip: '出張',
                house_work:    '社内',
                home:          '自待',
                drill:         '教練',
                absence:       '欠勤',
              }.with_indifferent_access

  PAID_HOLIDAY_VALUE = :paid_holiday
  NON_WORK_SITUASION_VALUE_LIST = [:holiday, :paid_holiday,  :transfer, :bereavement, :special, :house, :drill, :absence, :home]
  HOLIDAY_SITUATION_VALUE_LIST = [:holiday, :holiday_work]
  LIQUIDATION_VALUE_LIST = [:bereavement, :special, :home, :drill]

  DEFAULT_SITUATION = :holiday
  AT_WORK_SITUATION = :work

  default_value_for :situation, DEFAULT_SITUATION

  def set_work!
    return unless time_setting
    self.situation = AT_WORK_SITUATION
    self.from = time_setting.work_s
    self.to = time_setting.work_e
    set_working_hours_and_late_early
    save!
  end

  def set_working_hours_and_late_early
    self.working_hours = self.late_early = nil
    if time_format?
      self.working_hours = calc_working_hours
      self.late_early = calc_late_early if self.situation == "late_early"
    end
  end

  def work_day?
    return false if day_of_holiday.where(day: self.day).exists?
    (1..5).include?(self.day.wday) || day_of_work.where(day: self.day).present?
  end

  def day_of
    @day_of ||= DayOfWorkAndHoliday.where(day: roster.date.beginning_of_month..roster.date.end_of_month)
  end

  def day_of_holiday
    @day_of_holiday ||= day_of.where(day_type: DayOfWorkAndHoliday::DAY_TYPES[:holiday])
  end

  def day_of_work
    @day_of_work ||= day_of.where(day_type: DayOfWorkAndHoliday::DAY_TYPES[:work])
  end

private

  def time_cord_row
    @time_card_row ||= CalcWorkingHours::TimeCardRow.new(*row_data(self.from, self.to))
  end

  def calc_working_hours
    minite = time_cord_row.working_hours.minute
    # 15分でまるめている
    minite = minite - minite%15
    minite/60.0
  end

  def calc_late_early
    return nil if self.situation == 'holiday_work'
    base = CalcWorkingHours::WorkingHours.new(time_setting.base).minute

    tikoku = 0
    if time_setting.work_s.rjust(5, "0") < from.rjust(5, "0")
      tikoku_row_data = row_data(from, time_setting.work_e)
      tikoku = CalcWorkingHours::TimeCardRow.new(*tikoku_row_data).working_hours.minute
      tikoku = base - tikoku
      # 15分でまるめている
      tikoku = tikoku + 15 if tikoku%15 > 0
      tikoku = tikoku - tikoku%15
    end

    soutai = 0
    if time_setting.work_e.rjust(5, "0") > to.rjust(5, "0")
      soutai_row_data = row_data(time_setting.work_s, to)
      soutai = CalcWorkingHours::TimeCardRow.new(*soutai_row_data).working_hours.minute
      soutai = base - soutai
      # 15分でまるめている
      soutai = soutai + 15 if soutai%15 > 0
      soutai = soutai - soutai%15
    end

    late_early = tikoku + soutai

    late_early != 0 ? late_early/60.0 : nil
  end

  def row_data(from, to)
    return unless t = time_setting

    [day.strftime("%Y/%m/%d"), from, to].tap do |list|
      set_break_time(list, from, to, t.rest_first_s, t.rest_first_e)
      set_break_time(list, from, to, t.rest_second_s, t.rest_second_e)
      set_break_time(list, from, to, t.rest_therd_s, t.rest_therd_e)
      set_break_time(list, from, to, t.rest_fourth_s, t.rest_fourth_e)
      set_break_time(list, from, to, t.rest_fifth_s, t.rest_fifth_e)
      set_break_time(list, from, to, t.rest_sixth_s, t.rest_sixth_e)
    end
  end

  def time_setting
    @time_setting ||= company.try(:time_setting)
  end

  def set_break_time(list, work_start_time, work_end_time, rest_start_time, rest_end_time)
    return unless rest_start_time.present? && rest_end_time.present?

    if is_over_day?(work_end_time) && (work_start_time.rjust(5, "0") > rest_end_time.rjust(5, "0"))
      s = [work_start_time.rjust(5, "0"), adjust_end_time(rest_start_time)].max
      e = [work_end_time.rjust(5, "0"), adjust_end_time(rest_end_time)].min
    else
      s = [work_start_time.rjust(5, "0"), rest_start_time.rjust(5, "0")].max
      e = [work_end_time.rjust(5, "0"), rest_end_time.rjust(5, "0")].min
    end

    list << [s, e] if s < e
  end

  # 勤務終了時間が24時を越える深夜の場合の調整
  def adjust_end_time(rest_end_time)
    hour, minute = rest_end_time.split(":").map(&:to_i)
    hour += 24
    return "#{hour.to_s.rjust(2, "0")}:#{minute.to_s.rjust(2, "0")}"
  end

  def is_over_day?(work_end_time)
    return (work_end_time.rjust(5, "0") > "24:00")
  end

  def self.change_to_minute(str)
    /(\d+):(\d+)/ =~ str
    return $1.to_i * 60 + $2.to_i
  end

  def self.change_to_time_string(minute)
    hour = minute.div(60).to_s
    minute = (minute % 60).to_s
    if minute.length == 1
      minute = "0" + minute
    end
    return hour + ":" + minute
  end

  def time_format?
    return from =~ /(\d+):(\d+)/ && to =~ /(\d+):(\d+)/
  end
end
