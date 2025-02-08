class Api::V1::SleepRecordsController < ApplicationController
  before_action :set_user, only: [:index, :create, :clock_in]
  
  def index
    # sleep_records = @user.sleep_records.order(created_at: :desc)
    sleep_records = @user.sleep_records.order(sleep_time: :desc, created_at: :desc)
    
    render json: sleep_records, status: :ok
  end

  def create
    sleep_record = @user.sleep_records.new(sleep_record_params)
    if sleep_record.save
      render json: sleep_record, status: :created
    else
      render json: { errors: sleep_record.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def clock_in
    sleep_record = @user.sleep_records.create(sleep_time: Time.now)
    if sleep_record.persisted?
      render json: sleep_record, status: :created
    else
      render json: { errors: sleep_record.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def following_sleep_records
    user = User.find(params[:user_id])

    sleep_records = SleepRecord.joins(:user)
      .where(user: user.followed_users, sleep_time: 1.week.ago..Time.current)
      .order(Arel.sql("wake_time - sleep_time DESC NULLS LAST"))

    formatted_records = sleep_records.map do |record|
      {
        user_name: record.user.name,
        sleep_time: record.sleep_time,
        wake_time: record.wake_time,
        duration: record.sleep_duration
      }
    end

    render json: formatted_records, status: :ok
  end


  private

  def set_user
    @user = User.find_by(id: params[:user_id])
    render json: { error: "User not found" }, status: :not_found if @user.nil?
  end

  def sleep_record_params
    params.require(:sleep_record).permit(:sleep_time, :wake_time)
  end
end
