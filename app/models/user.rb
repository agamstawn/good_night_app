class User < ApplicationRecord
  has_many :sleep_records, dependent: :destroy

  has_many :followers, foreign_key: :followed_id, class_name: "Follow"
  has_many :followed_users, foreign_key: :follower_id, class_name: "Follow"
end
