class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :require_admin, except: [:index, :show]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    if params[:name].present?
      @products = Product.search(params[:name])
    else
      @products = Product.all
    end
  end

  def buy
    @product = Product.find(params[:id])
    render 'buy_success'
  end

  def show; end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: 'Product created successfully.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Product updated.'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: 'Product deleted.'
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :category_id, :image)
  end

  def require_admin
    redirect_to root_path, alert: 'Admins only.' unless current_user&.admin?
  end
end
