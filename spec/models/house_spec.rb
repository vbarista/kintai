# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  type       :string
#  name       :string           not null
#  code       :string           not null
#  delete_flg :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe House, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
