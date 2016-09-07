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

require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'Association' do
    it { should have_one(:rest_time) }
    it { should have_many(:users) }
    it { should have_many(:rosters) }
  end

  describe 'Validation' do
  end

end
