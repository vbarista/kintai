require 'rails_helper'

RSpec.describe "infos/show", type: :view do
  before(:each) do
    @info = assign(:info, Info.create!(
      :title => "MyText",
      :content => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
