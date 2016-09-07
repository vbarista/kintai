require 'rails_helper'

RSpec.describe OneDaysController, type: :controller do
  before {
    sign_in user if user
  }
  let(:user) { create(:user, :admin, company: company) }
  let(:company) { create(:company) }
  let(:roster) { create(:roster, company: company, user: user) }

  let(:valid_attributes) {
    attributes_for(:one_day)
  }

  let(:invalid_attributes) { skip("Add a hash of attributes invalid for your model") }

  describe "GET #index" do
    before {
      one_day
      request
    }
    let(:one_day) { create(:one_day, roster: roster) }
    let(:request) { get :index, { company_code: company.code, roster_id: roster.id } }

    it "assigns all one_days as @one_days" do
      expect(assigns(:one_days)).to eq([one_day])
    end
  end

  describe "GET #show" do
    before {
      one_day
      request
    }
    let(:one_day) { create(:one_day, roster: roster) }
    let(:request) { get :show, { company_code: company.code, roster_id: roster.id, id: one_day.id } }

    it "assigns the requested one_day as @one_day" do
      expect(assigns(:one_day)).to eq(one_day)
    end
  end

  describe "GET #new" do
    it "assigns a new one_day as @one_day" do
      get :new, { company_code: company.code, roster_id: roster.id }
      expect(assigns(:one_day)).to be_a_new(OneDay)
    end
  end

  describe "GET #edit" do
    let(:one_day) { create(:one_day, roster: roster) }
    let(:request) { get :edit, { company_code: company.code, roster_id: roster.id, id: one_day.id } }

    it "assigns the requested one_day as @one_day" do
      request
      expect(assigns(:one_day)).to eq(one_day)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:request) { post :create, { company_code: company.code, roster_id: roster.id, one_day: valid_attributes } }

      it "creates a new OneDay" do
        expect { request }.to change(OneDay, :count).by(1)
      end

      it "assigns a newly created one_day as @one_day" do
        request
        expect(assigns(:one_day)).to be_a(OneDay)
        expect(assigns(:one_day)).to be_persisted
      end

      it "redirects to the created one_day" do
        request
        expect(response).to redirect_to([company, roster, OneDay.last])
      end
    end

    context "with invalid params" do
      let(:request) { post :create, { company_code: company.code, roster_id: roster.id, one_day: invalid_attributes } }

      it "assigns a newly created but unsaved one_day as @one_day" do
        request
        expect(assigns(:one_day)).to be_a_new(OneDay)
      end

      it "re-renders the 'new' template" do
        request
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    before { one_day }
    let(:one_day) { create(:one_day, roster: roster) }

    context "with valid params" do
      let(:new_attributes) {
        { day: "1", from: Time.zone.now , to: Time.zone.now, total: 0 }
      }
      let(:request){
        put :update, { company_code: company.code, roster_id: roster.id, id: one_day.id, one_day: new_attributes }
      }

      it "updates the requested one_day" do
        request
        one_day.reload
      end

      it "assigns the requested one_day as @one_day" do
        request
        expect(assigns(:one_day)).to eq(one_day)
      end

      it "redirects to the one_day" do
        request
        expect(response).to redirect_to([company, roster, one_day])
      end
    end

    context "with invalid params" do
      let(:request){
        put :update, { company_code: company.code, roster_id: roster.id, id: one_day.id, one_day: invalid_attributes }
      }

      it "assigns the one_day as @one_day" do
        request
        expect(assigns(:one_day)).to eq(one_day)
      end

      it "re-renders the 'edit' template" do
        request
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    before { one_day }
    let(:one_day) { create(:one_day, roster: roster) }
    let(:request) { delete :destroy, { company_code: company.code, roster_id: roster.id, id: one_day.id } }

    it "destroys the requested one_day" do
      expect { request }.to change(OneDay, :count).by(-1)
    end

    it "redirects to the one_days list" do
      request
      expect(response).to redirect_to(company_roster_one_days_url(company, roster))
    end
  end

end
