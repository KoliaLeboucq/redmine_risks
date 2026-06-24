class RiskReview < ApplicationRecord
  belongs_to :risk
  belongs_to :author, class_name: 'User'

  validates :probability,  inclusion: { in: 1..5 }
  validates :impact,       inclusion: { in: 1..5 }
  validates :reviewed_at,  presence: true

  before_validation { self.reviewed_at ||= Time.current }
  after_create      :update_risk_score

  def score = probability * impact

  private

  def update_risk_score
    risk.update_columns(
      current_probability: probability,
      current_impact:      impact
    )
  end
end
