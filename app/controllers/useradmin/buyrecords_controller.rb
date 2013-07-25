#encoding: UTF-8
class Useradmin::BuyrecordsController < ApplicationController
  before_filter :authenticate_user!
  layout "useradmin"

  def index
  	@buyrecords = Deal.where("buyer_id = ?", current_user.id).all

  	respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @buyrecords }
    end  	
  end

  def show
  	@deal = Deal.where("buyer_id = ? and id = ?", current_user.id, params[:id]).first
  	@value = @deal.dealvalues.select("dealvalues.*").where("dealvalues.user_id = ?", @deal.buyer_id).last.value
    @dealask = Dealask.new  	
  end

  def createask
  	@dealask = Dealask.new(params[:dealask])
    @dealask.user_id = current_user.id
  	@dealask.deal_id = params[:id]
  	@dealask.save

  	respond_to do |format|
      format.html { redirect_to useradmin_buyrecord_path(params[:id]) }
      format.json { render json: @dealask }
    end 
  end

  def dealvalues
    @deal = Deal.where("buyer_id = ? and id = ?", current_user.id, params[:id]).first
    @value = @deal.dealvalues.select("dealvalues.*").where("dealvalues.user_id = ?", @deal.buyer_id).last.value
    @dealvalue = Dealvalue.new
  end

  def createvalue
    @dealvalue = Dealvalue.new(params[:dealvalue])
    @dealvalue.user_id = current_user.id
    @dealvalue.deal_id = params[:id]
    @dealvalue.save

    respond_to do |format|
      format.html { redirect_to dealvalues_useradmin_buyrecord_path(params[:id]) }
      format.json { render json: @dealvalue }
    end 
  end
end