require 'rails_helper'
require 'benchmark'

RSpec.describe "Api::V1::SleepRecordsController", type: :request do
  let!(:user) { User.create(name: "Test User") }

  before do
    1000.times do |i|
      user.sleep_records.create!(sleep_time: Time.now - (i+1).hours, wake_time: Time.now - i.hours)
    end
  end

  describe "GET /api/v1/users/:user_id/sleep_records" do
    it "returns sleep records in descending order and handles high volume" do
      time_taken = Benchmark.realtime do
        get "/api/v1/users/#{user.id}/sleep_records"
      end

      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq(1000)
      first_time = DateTime.parse(json_response.first["sleep_time"])
      last_time = DateTime.parse(json_response.last["sleep_time"])
      expect(first_time).to be > last_time

      puts "Response time for 1000 records: #{time_taken.round(3)}s"
    end
  end

  describe "POST /api/v1/users/:user_id/clock_in" do
    it "allows concurrent clock-in requests" do
      threads = []
      10.times do
        threads << Thread.new do
          post "/api/v1/users/#{user.id}/clock_in"
          expect(response).to have_http_status(:created)
        end
      end
      threads.each(&:join)
    end
  end

end
