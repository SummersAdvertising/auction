#encoding: UTF-8
class Useradmin::ProductsController < ApplicationController
  before_filter :authenticate_user!
  layout "useradmin"
  
  def index
    @products = current_user.products.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  def show
    @product = current_user.products.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @product = current_user.products.new(params[:product])
    @product.status = "上架"

    respond_to do |format|
      if @product.save
        format.html { redirect_to  useradmin_product_path(@product), notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to useradmin_product_path(@product), notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to useradmin_products_path }
      format.json { head :no_content }
    end
  end
end
