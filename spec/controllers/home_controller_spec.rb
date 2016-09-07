require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  before { controller.stub(:current_user).and_return(nil)  }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
