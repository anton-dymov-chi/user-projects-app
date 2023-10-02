class Api::V1::AssignmentsController < ApplicationController
  def index
    @assignments = Assignment
    if params[:assignmentable_id].present? && params[:assignmentable_type].present?
      @assignments = @assignments.by_assignmentable(params[:assignmentable_id], params[:assignmentable_type])
    end
    @assignments = @assignments.page(params[:page]).per(params[:per_page])
    render json: AssignmentSerializer.new(@assignments).serializable_hash
  end

  def show
    @assignment = Assignment.find(params[:id])
    render json: AssignmentSerializer.new(@assignment).serializable_hash
  end
  
  def create
    @assignment = Assignment.create!(assignment_params)
    render json: AssignmentSerializer.new(@assignment).serializable_hash
  end
  
  def update
    @assignment = Assignment.find(params[:id])
    @assignment.update!(assignment_params.compact)
    render json: AssignmentSerializer.new(@assignment).serializable_hash
  end

  private

  def assignment_params
    params.require(:assignment).permit(:months, :rnd_percentage, :project_id, :assignmentable_id, :assignmentable_type)
  end
end
