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

FactoryGirl.define do
  factory :company do
    name { "name-#{ code }" }
    sequence(:code) { |n| "code#{ n }" }
  end
end
