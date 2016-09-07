require 'rails_helper'

RSpec.describe "rosters/show", type: :view do
  before(:each) do
    @roster = assign(:roster, Roster.create!())
  end

  it "renders attributes in <p>" do
#    render
    skip("Adjusting layout")
  end
end
