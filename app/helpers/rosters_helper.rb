module RostersHelper
  def situation_select_options(one_day)
    if one_day.work_day?
      @work_day_options ||= OneDay::SITUASIONS.except(*OneDay::HOLIDAY_SITUATION_VALUE_LIST).invert
    else
      @holiday_options ||= OneDay::SITUASIONS.slice(*OneDay::HOLIDAY_SITUATION_VALUE_LIST).invert
    end
  end

  def liquidation_hour(r)
    r.total_hour_working.to_f + r.total_hour_house.to_f +
    (r.bereavement.to_f + r.home.to_f + r.special.to_f + r.drill.to_f) * Roster::BASE_WORK_HOUR
  end
end
