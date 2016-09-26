class RostersController < ApplicationAuthController
  before_action :user
  before_action :rosters
  before_action :roster, only: [:show, :edit, :update, :destroy]

  def index
#    [Date.today.prev_month, Date.today].each do |date|
    [Date.today].each do |date|
      rosters.find_or_create_by(company_id: user.company_id, year: date.year, month: sprintf('%02d', date.month))
    end
    @rosters = rosters.order('year DESC, month DESC')
  end

  def show
  end

  def edit
    ActiveRecord::Base::transaction do
      # １ヶ月分の日別勤務情報(OneDay)を取得 or 作成
      (roster.date.beginning_of_month..roster.date.end_of_month).each do |date|
        roster.one_days.find_or_initialize_by(day: date) do |od|
          if od.new_record?
            if od.work_day?
              od.company = user.partner || Partner.find_by_code('base') # 基本勤務時間
              od.set_work!
            end
            od.save!
          end
        end
      end
    end
  end

  def create
    @roster = rosters.update_attributes(roster_params)

    if @roster.save
      redirect_to [user.company, user, @roster], notice: 'Roster was successfully created.'
    else
      render :new
    end
  end

  def update
    if @roster.update_attributes(roster_params)
      redirect_to [user.company.to_company, user, @roster], notice: 'Roster was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @roster.destroy
    redirect_to company_rosters_url(user.company), notice: 'Roster was successfully destroyed.'
  end

  def reset_one_day
    # request params
    # {"roster"=>
    #   {"one_days_attributes"=>
    #     {"0"=>
    #       {"id"=>"1",
    #        "situation"=>"1",
    #        "company_id"=>"1",
    #        "from"=>"9:09",
    #        "to"=>"18:30",
    #        "working_hours"=>"8.0",
    #        "late_early"=>"",
    #        "note"=>""}}},
    #  "controller"=>"rosters",
    #  "action"=>"reset_one_day",
    #  "company_code"=>"xxxxx",
    #  "format"=>"js"}
    one_day_params = roster_params[:one_days_attributes].values.first
    @num = roster_params[:one_days_attributes].keys.first
    @one_day = OneDay.find(one_day_params[:id])
    @one_day.attributes = one_day_params
    @one_day.set_working_hours_and_late_early
    respond_to do |format|
      format.js
    end
  end

private

  def user
    if params[:user_id]
      @user ||= User.find(params[:user_id])
    else
      @user ||= current_user
    end
    @user
  end

  def rosters
    @rosters ||= user.rosters
  end

  def roster
    @roster ||= rosters.find(params[:id])
  end

  def roster_params
    params.require(:roster).permit(permit)
  end

  def permit
    [
      :status,
      :memo,
      :required_work_day,
      :total_work_day,
      :required_work_hour,
      :allowance_hour,
      :absence,
      :holiday_work,
      :home,
      :paid_holiday,
      :house_work,
      :bereavement,
      :transfer,
      :business_trip,
      :drill,
      :special,
      :total_hour_working,
      :total_hour_house,
      :total_hour_late_early,
      one_days_attributes: [
        :id,
        :situation,
        :company_id,
        :from,
        :to,
        :working_hours,
        :late_early,
        :house,
        :note,
      ]
    ]
  end

end
