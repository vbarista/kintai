require 'rails_helper'

RSpec.describe "one_days/index", type: :view do
  before(:each) do
    assign(:one_days, [
      OneDay.create!(),
      OneDay.create!()
    ])
  end

  it "renders a list of one_days" do
#    render
    skip("Adjusting layout")
  end
end
