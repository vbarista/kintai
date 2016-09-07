require "rails_helper"

RSpec.describe OneDaysController, type: :routing do
  describe "routing" do
    let(:company) { create(:company) }
    let(:user) { create(:user, company: company) }
    let(:roster) { create(:roster, company: company, user: user) }

    it "routes to #index" do
      expect(get: "/#{ company.code }/rosters/#{ roster.id }/one_days").to route_to("one_days#index", company_code: "#{ company.code }", roster_id: "#{ roster.id }")
    end

    it "routes to #new" do
      expect(get: "/#{ company.code }/rosters/#{ roster.id }/one_days/new").to route_to("one_days#new", company_code: "#{ company.code }", roster_id: "#{ roster.id }")
    end

    it "routes to #show" do
      expect(get: "/#{ company.code }/rosters/#{ roster.id }/one_days/1").to route_to("one_days#show", company_code: "#{ company.code }", roster_id: "#{ roster.id }", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/#{ company.code }/rosters/#{ roster.id }/one_days/1/edit").to route_to("one_days#edit", company_code: "#{ company.code }", roster_id: "#{ roster.id }", id: "1")
    end

    it "routes to #create" do
      expect(post: "/#{ company.code }/rosters/#{ roster.id }/one_days").to route_to("one_days#create", company_code: "#{ company.code }", roster_id: "#{ roster.id }")
    end

    it "routes to #update" do
      expect(put: "/#{ company.code }/rosters/#{ roster.id }/one_days/1").to route_to("one_days#update", company_code: "#{ company.code }", roster_id: "#{ roster.id }", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/#{ company.code }/rosters/#{ roster.id }/one_days/1").to route_to("one_days#destroy", company_code: "#{ company.code }", roster_id: "#{ roster.id }", id: "1")
    end

  end
end
