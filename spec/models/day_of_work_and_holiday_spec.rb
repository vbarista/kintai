# == Schema Information
#
# Table name: day_of_work_and_holidays
#
#  id         :integer          not null, primary key
#  company_id :integer
#  day_type   :integer
#  title      :string
#  day        :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe DayOfWorkAndHoliday, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
