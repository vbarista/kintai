require 'rails_helper'

RSpec.describe "one_days/show", type: :view do
  before(:each) do
    @one_day = assign(:one_day, OneDay.create!())
  end

  it "renders attributes in <p>" do
#    render
    skip("Adjusting layout")
  end
end
