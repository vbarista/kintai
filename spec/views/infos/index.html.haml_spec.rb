require 'rails_helper'

RSpec.describe "infos/index", type: :view do
  before(:each) do
    assign(:infos, [
      Info.create!(
        :title => "MyText",
        :content => "MyText"
      ),
      Info.create!(
        :title => "MyText",
        :content => "MyText"
      )
    ])
  end

  it "renders a list of infos" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
