require 'rails_helper'

RSpec.describe "Rosters", type: :request do
  let(:company) { create(:company) }
  let(:user) { create(:user, admin: admin, company: company) }
  let(:admin) { true }

  describe "GET /:company_code/rosters" do
    before {
      sign_in user if user
      get company_rosters_path(company)
    }

    describe "ログインユーザー" do
      context "管理者の場合" do
        let(:admin) { true }
        it { expect(response).to have_http_status(200) }
      end

      context "管理者ではない場合" do
        let(:admin) { false }
        it { expect(response).to have_http_status(200) }
      end
    end
  end
end
