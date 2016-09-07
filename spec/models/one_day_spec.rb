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

require 'rails_helper'

RSpec.describe OneDay, type: :model do
  describe 'Association' do
    it { should belong_to(:roster) }
  end
end
