# == Schema Information
#
# Table name: day_of_work_and_holidays
#
#  id         :integer          not null, primary key
#  company_id :integer
#  day_type   :integer
#  title      :string
#  day        :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DayOfWorkAndHoliday < ActiveRecord::Base
  belongs_to :company

  DAY_TYPES = { holiday: 0, work: 1 }

  default_value_for :day_type, 0 #休日
end
