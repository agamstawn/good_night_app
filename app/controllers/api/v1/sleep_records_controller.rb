class Api::V1::SleepRecordsController < ApplicationController
  before_action :set_user, only: [:index, :create, :clock_in]
  
  def index
    sleep_records = @user.sleep_records.order(created_at: :desc)
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

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def sleep_record_params
    params.require(:sleep_record).permit(:sleep_time, :wake_time)
  end
end
