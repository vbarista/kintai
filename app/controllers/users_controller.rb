class UsersController < ApplicationAuthController
  before_action :check_admin!
  before_action :users
  before_action :user, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def new
    @user = @users.new
  end

  def edit
  end

  def create
    @user = @users.new(user_params)

    if @user.save
      redirect_to [current_company, @user], notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to users_url,  notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to company_users_url, notice: 'User was successfully destroyed.'
  end

  private
    def users
      @users ||= User.all
    end
    def user
      @user = users.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :email, :partner_id)
    end

end
