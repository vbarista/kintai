require 'rails_helper'

RSpec.describe "infos/new", type: :view do
  before(:each) do
    assign(:info, Info.new(
      :title => "MyText",
      :content => "MyText"
    ))
  end

  it "renders new info form" do
    render

    assert_select "form[action=?][method=?]", infos_path, "post" do

      assert_select "textarea#info_title[name=?]", "info[title]"

      assert_select "textarea#info_content[name=?]", "info[content]"
    end
  end
end
