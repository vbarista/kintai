# == Schema Information
#
# Table name: rest_times
#
#  id         :integer          not null, primary key
#  company_id :integer
#  first      :string(11)
#  second     :string(11)
#  therd      :string(11)
#  fourth     :string(11)
#  fifth      :string(11)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :rest_time do
    company_id 1
    first "MyString"
    second "MyString"
    therd "MyString"
    fourth "MyString"
    fifth ""
  end

end
