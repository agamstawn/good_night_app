require 'rails_helper'

RSpec.describe Api::V1::SleepRecordsController, type: :controller do
  let(:user) { User.create(name: "Asep") }
  let(:valid_attributes) { { sleep_time: Time.now - 8.hours, wake_time: Time.now } }
  let(:invalid_attributes) { { sleep_time: nil } }

  describe "GET #index" do
    before do
      user.sleep_records.create(valid_attributes)
      get :index, params: { user_id: user.id }
    end

    it "returns a successful response" do
      expect(response).to have_http_status(:ok)
    end

  end

  describe "POST #create" do
    context "with valid parameters" do
      before do
        post :create, params: { user_id: user.id, sleep_record: valid_attributes }
      end
      
      it "returns a created status" do
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      before do
        post :create, params: { user_id: user.id, sleep_record: invalid_attributes }
      end

      it "returns an unprocessable entity status" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "POST #clock_in" do
    context "when clocking in successfully" do
      before do
        post :clock_in, params: { user_id: user.id }
      end

      it "creates a new sleep record with sleep_time set" do
        expect(SleepRecord.last.sleep_time).not_to be_nil
      end

      it "does not set wake_time initially" do
        expect(SleepRecord.last.wake_time).to be_nil
      end

      it "returns a created status" do
        expect(response).to have_http_status(:created)
      end
    end
    
    context "when user does not exist" do
      before do
        post :clock_in, params: { user_id: 9999 } # Non-existent user
      end
    
      it "returns a not found status" do
        expect(response).to have_http_status(:not_found)
      end
    
      it "returns an error message" do
        expect(JSON.parse(response.body)).to include("error" => "User not found")
      end
    end
  end
end
