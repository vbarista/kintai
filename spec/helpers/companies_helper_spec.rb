require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the CompaniesHelper. For example:
#
# describe CompaniesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe CompaniesHelper, type: :helper do
  let(:html) do
    helper.extend(Haml, Haml::Helpers)
    helper.send(:init_haml_helpers)
    Capybara.string(helper.test)
  end

  it { expect(html).to have_content("test") }

end
