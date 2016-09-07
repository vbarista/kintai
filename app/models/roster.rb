# == Schema Information
#
# Table name: rosters
#
#  id                    :integer          not null, primary key
#  company_id            :integer
#  user_id               :integer
#  year                  :string
#  month                 :string
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

class Roster < ActiveRecord::Base
  BASE_WORK_HOUR = 8.0

  belongs_to :company
  belongs_to :user
  has_many :one_days

  accepts_nested_attributes_for :one_days, allow_destroy: false

  default_value_for :memo, '未編集'

  def date
    @date ||= Date.new(year.to_i, month.to_i)
  end

end
