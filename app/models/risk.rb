class Risk < ApplicationRecord
  STATUSES    = %w[open mitigated accepted closed].freeze
  CATEGORIES  = %w[threat opportunity].freeze
  SCALE       = (1..5).freeze

  belongs_to :project
  belongs_to :author,      class_name: 'User'
  belongs_to :assigned_to, class_name: 'User', optional: true
  has_many   :risk_reviews,            dependent: :destroy
  has_many   :risk_mitigation_actions, dependent: :destroy

  validates :title,                presence: true
  validates :status,               inclusion: { in: STATUSES }
  validates :category,             inclusion: { in: CATEGORIES }
  validates :initial_probability,  inclusion: { in: SCALE }
  validates :initial_impact,       inclusion: { in: SCALE }
  validates :current_probability,  inclusion: { in: SCALE }
  validates :current_impact,       inclusion: { in: SCALE }

  scope :open,     -> { where(status: 'open') }
  scope :critical, -> { where('current_probability * current_impact >= 15') }
  scope :overdue_review, -> { where('review_date < ?', Date.today).where(status: 'open') }

  def initial_score  = initial_probability  * initial_impact
  def current_score  = current_probability  * current_impact

  def trend
    diff = current_score - initial_score
    return :down   if diff < 0
    return :up     if diff > 0
    :stable
  end

  def criticality
    case current_score
    when 1..4   then :low
    when 5..9   then :medium
    when 10..14 then :high
    else             :critical
    end
  end

  def visible?(user = User.current)
    user.allowed_to?(:view_risks, project)
  end

  def editable?(user = User.current)
    user.allowed_to?(:manage_risks, project)
  end
end
