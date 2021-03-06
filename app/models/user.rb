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

class User < ActiveRecord::Base
  # バージョニング対象
  has_paper_trail
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :company
  belongs_to :partner
  has_many :rosters, dependent: :destroy
  has_many :info_for_each_fiscal_years, dependent: :destroy

  # see https://github.com/sferik/rails_admin/issues/2265
  rails_admin do
    configure :password_reset

    edit do
      exclude_fields :password, :password_confirmation
      include_fields :password_reset
    end
  end

  # Provided for Rails Admin to allow the password to be reset
  def password_reset; nil; end

  def password_reset=(value)
    return nil if value.blank?
    self.password = value
    self.password_confirmation = value
  end

end
