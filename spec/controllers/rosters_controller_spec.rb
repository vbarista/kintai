require 'rails_helper'

RSpec.describe RostersController, type: :controller do
  before {
    sign_in user if user
  }
  let(:user) { create(:user, :admin, company: company) }
  let(:company) { create(:company) }

  let(:valid_attributes) {
    attributes_for(:roster)
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET #index" do
    let(:request) { get :index, { company_code: company.code } }

    it "assigns all rosters as @rosters" do
      request
      expect(assigns(:rosters).size).to eq(3)
    end
  end

  describe "GET #show" do
    before {
      roster
      request
    }
    let(:roster) { create(:roster, company: company, user: user) }
    let(:request) { get :show, { company_code: company.code, id: roster.id } }

    it "assigns all rosters as @rosters" do
      expect(assigns(:roster)).to eq(roster)
    end
  end

  describe "GET #edit" do
    let(:roster) { create(:roster, company: company, user: user) }
    let(:request) { get :edit, { company_code: company.code, id: roster.id } }

    it "assigns the requested roster as @roster" do
      request
      expect(assigns(:roster)).to eq(roster)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:request) { post :create, { company_code: company.code, roster: valid_attributes } }

      it "creates a new Roster" do
        expect { request }.to change(Roster, :count).by(1)
      end

      it "assigns a newly created roster as @roster" do
        request
        expect(assigns(:roster)).to be_a(Roster)
        expect(assigns(:roster)).to be_persisted
      end

      it "redirects to the created roster" do
        request
        expect(response).to redirect_to([company, Roster.last])
      end
    end

    context "with invalid params" do
      let(:request) { post :create, { company_code: company.code, roster: invalid_attributes } }

      it "assigns a newly created but unsaved roster as @roster" do
        request
        expect(assigns(:roster)).to be_a_new(Roster)
      end

      it "re-renders the 'new' template" do
        request
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    before { roster }
    let(:roster) { create(:roster, company: company, user: user) }

    context "with valid params" do
      let(:new_attributes) {
        { user_id: user.id, year: "2015", month: "5", memo: "" }
      }
      let(:request){
        put :update, { company_code: company.code, id: roster.id, roster: new_attributes }
      }

      it "updates the requested roster" do
        request
        roster.reload
      end

      it "assigns the requested roster as @roster" do
        request
        expect(assigns(:roster)).to eq(roster)
      end

      it "redirects to the roster" do
        request
        expect(response).to redirect_to([company, roster])
      end
    end

    context "with invalid params" do
      let(:request){
        put :update, { company_code: company.code, id: roster.id, roster: invalid_attributes }
      }

      it "assigns the roster as @roster" do
        request
        expect(assigns(:roster)).to eq(roster)
      end

      it "re-renders the 'edit' template" do
        request
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    before { roster }
    let(:roster) { create(:roster, company: company, user: user) }
    let(:request) { delete :destroy, { company_code: company.code, id: roster.id } }

    it "destroys the requested roster" do
      expect { request }.to change(Roster, :count).by(-1)
    end

    it "redirects to the rosters list" do
      request
      expect(response).to redirect_to(company_rosters_url(company))
    end
  end

end
