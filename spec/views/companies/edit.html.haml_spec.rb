require 'rails_helper'

RSpec.describe "companies/edit", type: :view do
  before(:each) do
    @company = assign(:company, Company.create!(
      :name => "MyString",
      :code => "MyString"
    ))
  end

  it "renders the edit company form" do
    render

    assert_select "form[action=?][method=?]", company_path(@company), "post" do

      assert_select "input#company_name[name=?]", "company[name]"

      assert_select "input#company_code[name=?]", "company[code]"
    end
  end
end
