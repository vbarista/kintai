require "rails_helper"

RSpec.describe RostersController, type: :routing do
  describe "routing" do
    let(:company) { create(:company) }

    it "routes to #index" do
      expect(get: "/#{ company.code }/rosters").to route_to("rosters#index", company_code: "#{ company.code }")
    end

    it "routes to #show" do
      expect(get: "/#{ company.code }/rosters/1").to route_to("rosters#show", company_code: "#{ company.code }", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/#{ company.code }/rosters/1/edit").to route_to("rosters#edit", company_code: "#{ company.code }", id: "1")
    end

    it "routes to #create" do
      expect(post: "/#{company.code}/rosters").to route_to("rosters#create", company_code: "#{ company.code }")
    end

    it "routes to #update" do
      expect(put: "/#{company.code}/rosters/1").to route_to("rosters#update", company_code: "#{ company.code }", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/#{company.code}/rosters/1").to route_to("rosters#destroy", company_code: "#{ company.code }", id: "1")
    end

  end

end
