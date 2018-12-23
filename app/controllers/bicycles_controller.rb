class BicyclesController < ApplicationController

  require 'pry'

  before_action :authenticate_user!, only: [:create, :new, :destroy, :update]
  before_action :set_bicycle, only: [:edit, :update, :destroy]

  def index
    @bicycles = Bicycle.all.page(params[:page])
  end

  def show
    @bicycle = Bicycle.find(params[:id])
    @rental_relation = @bicycle.rental_relations.build(borrow_user_id: current_user.id)
  end

  def new
    @bicycle = Bicycle.new
  end

  def create
    @bicycle = current_user.bicycles.build(bicycle_params)

    if @bicycle.save
      flash[:succress] = '自転車が正常に登録されました'
      redirect_to @bicycle
    else
      if !@bicycle.name.present?
        flash[:danger] = '自転車の名前を入力してください'
      else
        flash[:danger] = '自転車の登録に失敗しました'
      end
      render :new
    end
  end

  def edit
  end

  def update
    if @bicycle.update(bicycle_params)
      redirect_to @bicycle
    else
      if !@bicycle.name.present?
        flash[:danger] = '自転車の名前を入力してください'
      else
        flash[:danger] = '自転車の登録に失敗しました'
      end
      render :new
    end
  end

  def destroy
    @bicycle.destroy

    flash[:success] = 'bicycle は正常に削除されました'
    redirect_to mypages_index_path
  end
end

private

def set_bicycle
    @bicycle = current_user.bicycles.find(params[:id])
end

def bicycle_params
  params.require(:bicycle).permit(:name, :bicycle_type, :user, :image)
end