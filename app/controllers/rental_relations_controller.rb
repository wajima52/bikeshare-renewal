class RentalRelationsController < ApplicationController
  before_action :authenticate_user!

  require 'pry'
  def index
    @bicycle = current_user.bicycles.find(params[:id])
    @borrow_users = Bicycle.find(params[@bicycle.id]).borrow_users
  end

  def create
    bicycle = Bicycle.find(params[:bicycle_id])
    current_user.borrow(bicycle)
    flash[:success] = 'この自転車のレンタルを申し込みました。'
    redirect_to bicycle
  end

  def edit
  end

  def update
  end

  def destroy
    bicycle = Bicycle.find(params[:bicycle_id])
    current_user.cancel(bicycle)
    flash[:success] = 'この自転車のレンタル申し込みををキャンセルしました。'
    redirect_to bicycle
  end
end
