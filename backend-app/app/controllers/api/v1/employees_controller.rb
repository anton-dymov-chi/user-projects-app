class Api::V1::EmployeesController < ApplicationController
  def index
    @employees = Employee.page(params[:page] || 1).per(params[:per_page] || 25)
    render json: EmployeeSerializer.new(@employees).serializable_hash
  end

  def show
    @employee = Employee.find(params[:id].to_i)
    render json: EmployeeSerializer.new(@employee).serializable_hash
  end
end
