# == Schema Information
#
# Table name: info_for_each_fiscal_years
#
#  id                          :integer          not null, primary key
#  company_id                  :integer
#  user_id                     :integer
#  year                        :string
#  carry_over_paid_leave_count :string
#  carry_over_late_ealy        :string
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#

require 'rails_helper'

RSpec.describe InfoForEachFiscalYear, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
