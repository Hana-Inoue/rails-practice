class Schedule < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :scheduled_for, presence: true
  validates :scheduled_by, presence: true, length: { maximum: 30 }

  scope :search, -> (schedules_search_params) do
    return if schedules_search_params.blank?

    name_like(schedules_search_params[:name])
  end
  scope :sql_injection_search, -> (schedules_search_params) do
    return if schedules_search_params.blank?

    sql_injection_name_like(schedules_search_params[:name])
  end
  scope :name_like, -> (name) do
    where('name LIKE ?', "#{sanitize_sql_like(name)}") if name.present?
  end
  scope :sql_injection_name_like, -> (name) { where("name LIKE '#{name}'") if name.present? }
end
