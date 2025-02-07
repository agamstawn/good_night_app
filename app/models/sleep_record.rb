class SleepRecord < ApplicationRecord
  belongs_to :user

  validates :sleep_time, presence: true
  validate :wake_time_after_sleep_time

  def sleep_duration
    end_time = wake_time || Time.current 
    (end_time - sleep_time) / 3600.0 
  end

  private

  def wake_time_after_sleep_time
    if wake_time.present? && wake_time <= sleep_time
      errors.add(:wake_time, "must be after sleep time")
    end
  end

end
