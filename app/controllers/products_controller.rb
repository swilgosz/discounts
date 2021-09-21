# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_product, only: %i[ destroy ]

  # GET /products or /products.json
  def index
    @products = Product.all
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to root_url, notice: "Product was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH /products/:id
  def buy
    endpoint = Ordering::Endpoints::BuyProduct.new(event_store: Rails.configuration.event_store)
    endpoint.call(order: @order.id, product: params[:id])
    redirect_to root_url, notice: 'Your product had been added to the basket'
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: "Product was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:code, :name, :price)
    end
end
