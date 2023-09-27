class Api::V1::AssignmentsController < ApplicationController
  def index
    @assignments = Assignment.all
    render json: @assignments
  end

  def show
    @assignment = Assignment.find(id: params[:id])
    render json: @assigment
  end
  
  def create
    @assigment = Assignment.new(params[:assigment])
    if @assigment.save
      flash[:success] = "Object successfully created"
      redirect_to @assigment
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end
  
  def update
    @assigment = Assignment.find(params[:id])
    if @assigment.update_attributes(params[:ass@assigment])
      flash[:success] = "Object was successfully updated"
      redirect_to @assigment
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end
  
end
