class Api::V1::EmployeesController < ApplicationController
  def index
    @employees = Employee.page(params[:page] || 10).per(params[:per_page] || 25)
    render json: @employees
  end

  def show
    @employee = Employee.find(id: params[:id])
    render json: @employee
  end
end
