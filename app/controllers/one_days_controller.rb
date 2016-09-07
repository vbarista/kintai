class OneDaysController < ApplicationAuthController
  before_action :roster
  before_action :one_day, only: [:show, :edit, :update, :destroy]

  def index
    @one_days = roster.one_days
  end

  def show
  end

  def new
    @one_day = one_days.build()
  end

  def edit
  end

  def create
    @one_day = one_days.build(one_day_params)

    if @one_day.save
      redirect_to [current_company, roster, @one_day], notice: 'One day was successfully created.'
    else
      render :new
    end
  end

  def update
    if one_day.update(one_day_params)
      redirect_to [current_company, roster, one_day], notice: 'One day was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    one_day.destroy
    redirect_to company_roster_one_days_url(current_company, roster), notice: 'One day was successfully destroyed.'
  end

  private
    def roster
      @roster ||= current_company.rosters.find(params[:roster_id])
    end

    def one_days
      @one_days ||= roster.one_days
    end

    def one_day
      @one_day = one_days.find(params[:id])
    end

    def one_day_params
      params.require(:one_day).permit(:from, :to, :total)
    end

end
