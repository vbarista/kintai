require 'rails_helper'

RSpec.describe "one_days/edit", type: :view do
  before(:each) do
    @one_day = assign(:one_day, OneDay.create!())
  end

  it "renders the edit one_day form" do
#    render
#
#    assert_select "form[action=?][method=?]", one_day_path(@one_day), "post" do
#    end
    skip("Adjusting layout")
  end
end
