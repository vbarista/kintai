require 'spec_helper'

RSpec.describe "Companies", type: :request do
  let(:company) { create(:company) }

  describe "GET /companies" do
    before {
      sign_in user if user
      get companies_path
    }

    describe "ログインユーザー" do
      context "管理者の場合" do
        let(:user) { create(:user, :admin, company: company) }
        it { expect(response).to have_http_status(200) }
      end

      context "管理者ではない場合" do
        let(:user) { create(:user, company: company) }
        it { expect(response).to have_http_status(302) }
      end
    end
  end

end
