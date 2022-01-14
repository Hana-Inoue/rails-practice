class Event < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :body, presence: true, length: { maximum: 140 }
  validates :max_participants, presence: true
  validates :start_at, presence: true
  validates :finish_at, presence: true
  validates :host, presence: true, length: { maximum: 30 }

  validate :finish_at_after_start_at

  def start_and_finish_datetime
    "#{format_datetime(start_at)} ~ #{format_datetime(finish_at)}"
  end

  def format_datetime(datetime)
    datetime.strftime("%F %H:%M")
  end

  private

  def finish_at_after_start_at
    errors.add(:finish_at, :invalid) unless start_at < finish_at
  end
end
