require 'rails_helper'

RSpec.describe "one_days/new", type: :view do
  before(:each) do
    assign(:one_day, OneDay.new())
  end

  it "renders new one_day form" do
#    render
#
#    assert_select "form[action=?][method=?]", one_days_path, "post" do
#    end
    skip("Adjusting layout")
  end
end
