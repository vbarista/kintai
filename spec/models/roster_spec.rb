# == Schema Information
#
# Table name: rosters
#
#  id                    :integer          not null, primary key
#  company_id            :integer
#  user_id               :integer
#  year                  :string
#  month                 :string
#  status                :string
#  memo                  :string
#  required_work_day     :string
#  total_work_day        :string
#  required_work_hour    :string
#  allowance_hour        :string
#  absence               :string
#  holiday_work          :string
#  home                  :string
#  paid_holiday          :string
#  house_work            :string
#  bereavement           :string
#  transfer              :string
#  business_trip         :string
#  drill                 :string
#  special               :string
#  total_hour_working    :string
#  total_hour_house      :string
#  total_hour_late_early :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require 'rails_helper'

RSpec.describe Roster, type: :model do
  describe 'Association' do
    it { should belong_to(:company) }
    it { should have_many(:one_days) }
  end
end
