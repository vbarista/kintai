require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe InfosController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Info. As you add validations to Info, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # InfosController. Be sure to keep this updated too.
  let(:valid_session) { {} }
  
  let(:admin_user) do
      fn = House.create(name: 'house', code: 'house')
      User.create(name: "山田 太郎", admin: true, company: fn, email: "admin@admin.jp", password: "admin@admin.jp",
                  grant_date_of_paid_leave: Date.new(2012, 10, 1))
  end

  describe "GET #index" do
    it "assigns all infos as @infos" do
      info = Info.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:infos)).to eq([info])
    end
  end

  describe "GET #show" do
    it "assigns the requested info as @info" do
      info = Info.create! valid_attributes
      get :show, {:id => info.to_param}, valid_session
      expect(assigns(:info)).to eq(info)
    end
  end

  describe "GET #new" do
    it "assigns a new info as @info" do
      sign_in admin_user
      get :new, {}, valid_session
      expect(assigns(:info)).to be_a_new(Info)
    end
  end

  describe "GET #edit" do
    it "assigns the requested info as @info" do
      sign_in admin_user
      info = Info.create! valid_attributes
      get :edit, {:id => info.to_param}, valid_session
      expect(assigns(:info)).to eq(info)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Info" do
        sign_in admin_user
        expect {
          post :create, {:info => valid_attributes}, valid_session
        }.to change(Info, :count).by(1)
      end

      it "assigns a newly created info as @info" do
        sign_in admin_user
        post :create, {:info => valid_attributes}, valid_session
        expect(assigns(:info)).to be_a(Info)
        expect(assigns(:info)).to be_persisted
      end

      it "redirects to the created info" do
        sign_in admin_user
        post :create, {:info => valid_attributes}, valid_session
        expect(response).to redirect_to(Info.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved info as @info" do
        sign_in admin_user
        post :create, {:info => invalid_attributes}, valid_session
        expect(assigns(:info)).to be_a_new(Info)
      end

      it "re-renders the 'new' template" do
        sign_in admin_user
        post :create, {:info => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested info" do
        info = Info.create! valid_attributes
        put :update, {:id => info.to_param, :info => new_attributes}, valid_session
        info.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested info as @info" do
        info = Info.create! valid_attributes
        put :update, {:id => info.to_param, :info => valid_attributes}, valid_session
        expect(assigns(:info)).to eq(info)
      end

      it "redirects to the info" do
        info = Info.create! valid_attributes
        put :update, {:id => info.to_param, :info => valid_attributes}, valid_session
        expect(response).to redirect_to(info)
      end
    end

    context "with invalid params" do
      it "assigns the info as @info" do
        info = Info.create! valid_attributes
        put :update, {:id => info.to_param, :info => invalid_attributes}, valid_session
        expect(assigns(:info)).to eq(info)
      end

      it "re-renders the 'edit' template" do
        info = Info.create! valid_attributes
        put :update, {:id => info.to_param, :info => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested info" do
      info = Info.create! valid_attributes
      expect {
        delete :destroy, {:id => info.to_param}, valid_session
      }.to change(Info, :count).by(-1)
    end

    it "redirects to the infos list" do
      info = Info.create! valid_attributes
      delete :destroy, {:id => info.to_param}, valid_session
      expect(response).to redirect_to(infos_url)
    end
  end

end
