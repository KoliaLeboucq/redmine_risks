class RiskReviewsController < ApplicationController
  before_action :find_risk
  before_action :authorize

  def new
    @review = @risk.risk_reviews.build(
      probability: @risk.current_probability,
      impact:      @risk.current_impact,
      reviewed_at: Time.current
    )
  end

  def create
    @review = @risk.risk_reviews.build(review_params)
    @review.author = User.current
    if @review.save
      flash[:notice] = l(:notice_review_saved)
      redirect_to risk_path(@risk)
    else
      render :new
    end
  end

  private

  def find_risk
    @risk    = Risk.find(params[:risk_id])
    @project = @risk.project
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def review_params
    params.require(:risk_review).permit(:probability, :impact, :comment, :decision, :reviewed_at)
  end
end
