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
end
