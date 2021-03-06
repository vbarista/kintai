# == Schema Information
#
# Table name: users
#
#  id                       :integer          not null, primary key
#  admin                    :boolean
#  company_id               :integer          not null
#  name                     :string           not null
#  partner_id               :integer
#  grant_date_of_paid_leave :date
#  email                    :string           default(""), not null
#  encrypted_password       :string           default(""), not null
#  reset_password_token     :string
#  reset_password_sent_at   :datetime
#  remember_created_at      :datetime
#  sign_in_count            :integer          default(0), not null
#  current_sign_in_at       :datetime
#  last_sign_in_at          :datetime
#  current_sign_in_ip       :string
#  last_sign_in_ip          :string
#  created_at               :datetime
#  updated_at               :datetime
#

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Association' do
    it { should belong_to(:company) }
  end
 
  describe 'Validation' do
  end

end
