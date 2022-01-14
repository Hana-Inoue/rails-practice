class Event < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :body, presence: true, length: { maximum: 140 }
  validates :max_participants, presence: true
  validates :start_at, presence: true
  validates :finish_at, presence: true
  validates :host, presence: true, length: { maximum: 30 }

  validate :finish_at_after_start_at, if: :start_at_and_finish_at_present?

  scope :search, -> (events_search_params) do
    return if events_search_params.blank?

    title_like(events_search_params[:title])
      .start_after(events_search_params[:start_at])
      .finish_before(events_search_params[:finish_at])
      .max_participants_between(min_max_participants(events_search_params[:min_max_participants]))
      .body_like(events_search_params[:body])
      .host_like(events_search_params[:host])
  end
  scope :title_like, -> (title) { where('title LIKE ?', "%#{title}%") if title.present? }
  scope :start_after, -> (start_at) { where('? <= start_at', start_at) if start_at.present? }
  scope :finish_before, -> (finish_at) { where('finish_at <= ?', finish_at) if finish_at.present? }
  scope :max_participants_between, -> (min_max_participants) do
    where(max_participants: min_max_participants) if min_max_participants.present?
  end
  scope :body_like, -> (body) { where('body LIKE ?', "%#{body}%") if body.present? }
  scope :host_like, -> (host) { where('host LIKE ?', "%#{host}%") if host.present? }

  def self.min_max_participants(selected_value)
    case selected_value
    when '1'
      1..5
    when '2'
      6..10
    when '3'
      11..20
    when '4'
      21..30
    when '5'
      31..
    end
  end

  def start_and_finish_datetime
    "#{format_datetime(start_at)} ~ #{format_datetime(finish_at)}"
  end

  def format_datetime(datetime)
    datetime.strftime("%F %H:%M")
  end

  private

  def start_at_and_finish_at_present?
    start_at.present? && finish_at.present?
  end

  def finish_at_after_start_at
    errors.add(:finish_at, :invalid) unless start_at < finish_at
  end
end
