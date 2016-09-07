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

FactoryGirl.define do
  factory :one_day do
    day "2015/04/15"
    from "9:00"
    to "18:00"
    total "8:00"
    note "備考"
  end

end
