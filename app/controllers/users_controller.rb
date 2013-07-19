#encoding: UTF-8
class UsersController < ApplicationController
  before_filter :find_user

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def products
    @products = Product.where(:status => "上架", :user_id => params[:id]).all
    respond_to do |format|
      format.html 
    end
  end

  def orders
    respond_to do |format|
      format.html 
    end
  end

  def find_user
    @user = User.find(params[:id])
  end

end