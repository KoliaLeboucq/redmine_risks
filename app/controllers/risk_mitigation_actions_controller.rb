class RiskMitigationActionsController < ApplicationController
  before_action :find_risk
  before_action :find_action, only: [:edit, :update, :destroy]
  before_action :authorize

  def new
    @action = @risk.risk_mitigation_actions.build
  end

  def create
    @action = @risk.risk_mitigation_actions.build(action_params)
    if @action.save
      flash[:notice] = l(:notice_action_created)
      redirect_to risk_path(@risk)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @action.update(action_params)
      flash[:notice] = l(:notice_successful_update)
      redirect_to risk_path(@risk)
    else
      render :edit
    end
  end

  def destroy
    @action.destroy
    redirect_to risk_path(@risk)
  end

  private

  def find_risk
    @risk    = Risk.find(params[:risk_id])
    @project = @risk.project
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def find_action
    @action = @risk.risk_mitigation_actions.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def action_params
    params.require(:risk_mitigation_action).permit(
      :title, :description, :action_type,
      :status, :assigned_to_id, :due_date, :issue_id
    )
  end
end
