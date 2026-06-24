class RiskMitigationAction < ApplicationRecord
  STATUSES      = %w[open in_progress done cancelled].freeze
  ACTION_TYPES  = %w[reduce_probability reduce_impact transfer accept].freeze

  belongs_to :risk
  belongs_to :assigned_to, class_name: 'User', optional: true
  belongs_to :issue, optional: true

  validates :title,       presence: true
  validates :status,      inclusion: { in: STATUSES }
  validates :action_type, inclusion: { in: ACTION_TYPES }

  scope :open,    -> { where(status: %w[open in_progress]) }
  scope :overdue, -> { open.where('due_date < ?', Date.today) }
end
