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

FactoryGirl.define do
  factory :day_of_work_and_holiday do
    
  end

end
