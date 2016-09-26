# == Schema Information
#
# Table name: time_settings
#
#  id            :integer          not null, primary key
#  company_id    :integer
#  base          :string
#  work_s        :string(5)
#  work_e        :string(5)
#  rest_first_s  :string(5)
#  rest_first_e  :string(5)
#  rest_second_s :string(5)
#  rest_second_e :string(5)
#  rest_therd_s  :string(5)
#  rest_therd_e  :string(5)
#  rest_fourth_s :string(5)
#  rest_fourth_e :string(5)
#  rest_fifth_s  :string(5)
#  rest_fifth_e  :string(5)
#  rest_sixth_s  :string(5)
#  rest_sixth_e  :string(5)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe TimeSetting, type: :model do
  describe 'Association' do
    it { should belong_to(:company) }
  end
end
