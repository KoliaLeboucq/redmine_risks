class RisksController < ApplicationController
  before_action :find_project_by_project_id, only: [:index, :new, :create, :dashboard]
  before_action :find_risk,                  only: [:show, :edit, :update, :destroy]
  before_action :authorize

  def index
    @risks = @project.risks
                     .includes(:assigned_to, :risk_mitigation_actions)
                     .order(created_at: :desc)
    @risks = @risks.where(status: params[:status]) if params[:status].present?
  end

  def dashboard
    risks = @project.risks.includes(:risk_mitigation_actions)
    @open_count     = risks.where(status: 'open').count
    @critical_count = risks.critical.count
    @rising_risks   = risks.select { |r| r.trend == :up }
    @overdue_review = risks.overdue_review.count
    @no_action_open = risks.open.select { |r| r.risk_mitigation_actions.none? }
    @recent_risks   = risks.order(updated_at: :desc).limit(5)
  end

  def show
    @reviews  = @risk.risk_reviews.order(reviewed_at: :desc)
    @actions  = @risk.risk_mitigation_actions.includes(:assigned_to)
  end

  def new
    @risk = @project.risks.build(
      author:               User.current,
      initial_probability:  3,
      initial_impact:       3,
      current_probability:  3,
      current_impact:       3
    )
  end

  def create
    @risk = @project.risks.build(risk_params)
    @risk.author = User.current
    if @risk.save
      flash[:notice] = l(:notice_risk_created)
      redirect_to risk_path(@risk)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @risk.update(risk_params)
      flash[:notice] = l(:notice_successful_update)
      redirect_to risk_path(@risk)
    else
      render :edit
    end
  end

  def destroy
    @risk.destroy
    flash[:notice] = l(:notice_successful_delete)
    redirect_to project_risks_path(@risk.project)
  end

  private

  def find_risk
    @risk    = Risk.find(params[:id])
    @project = @risk.project
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def risk_params
    params.require(:risk).permit(
      :title, :description, :cause, :consequence,
      :category, :status, :assigned_to_id, :review_date,
      :initial_probability, :initial_impact,
      :current_probability, :current_impact
    )
  end
end
