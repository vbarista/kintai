# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  type       :string
#  name       :string           not null
#  code       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Company < ActiveRecord::Base
  def to_param
    code
  end

  has_one  :time_setting
  has_many :users,                    dependent: :destroy
  has_many :rosters,                  dependent: :destroy
  has_many :day_of_work_and_holidays, dependent: :destroy
  has_many :one_days,                 dependent: :destroy

  def to_company
    becomes(Company)
  end
end
