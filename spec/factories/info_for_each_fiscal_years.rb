# == Schema Information
#
# Table name: info_for_each_fiscal_years
#
#  id                          :integer          not null, primary key
#  company_id                  :integer
#  user_id                     :integer
#  year                        :string
#  carry_over_paid_leave_count :string
#  carry_over_late_ealy        :string
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#

FactoryGirl.define do
  factory :info_for_each_fiscal_year do
    company_id 1
user_id 1
year "MyString"
grant_data_of_paid_leave "2016-09-15"
carry_over_paid_leave_count "MyString"
carry_over_late_ealy "MyString"
  end

end
