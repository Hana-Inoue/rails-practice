class Schedule < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :scheduled_for, presence: true
  validates :scheduled_by, presence: true, length: { maximum: 30 }

  scope :search, -> (schedules_search_params) do
    return if schedules_search_params.blank?
    return unless name.present?
    where('name LIKE ?', "#{sanitize_sql_like(schedules_search_params[:name])}")
  end
  scope :sql_injection_search, -> (schedules_search_params) do
    return if schedules_search_params.blank?
    return unless name.present?
    where("name LIKE '#{schedules_search_params[:name]}'")
  end
end
