class Event < ApplicationRecord

  validates :title, presence: true, length: { maximum: 30 }
  validates :body, presence: true, length: { maximum: 140 }
  validates :max_participants, presence: true
  validates :start_at, presence: true
  validates :finish_at, presence: true
  validates :host, presence: true, length: { maximum: 30 }

  validate :finish_at_after_start_at

  scope :search, -> (search_params) do
    return if search_params.blank?

    title_like(search_params[:title])
      .start_after(search_params[:start_at])
      .finish_before(search_params[:finish_at])
      .max_participants_between(min_max_participants(search_params[:min_max_participants]))
      .body_like(search_params[:body])
      .host_like(search_params[:host])
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

  def finish_at_after_start_at
    errors.add(:finish_at, :invalid) unless start_at < finish_at
  end
end
