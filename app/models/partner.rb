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

class Partner < Company
end
