class MypagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @bicycles = current_user.bicycles.order('created_at DESC').page(params[:page])
  end

  def show
  end
end
