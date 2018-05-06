class ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[create update destroy]
  before_action :authenticate_user!
  before_action :user_is_admin?
  before_action :find_products, only: %i[index]
  before_action :find_product, only: %i[edit update destroy]

  def index; end

  def new; end

  def create
    product = Product.new(product_params)
    if product.save
      redirect_to edit_product_path(product)
    else
      render :new
    end
  end

  def edit; end

  def update
    @product.update(product_params)
    redirect_to events_path
  end

  def destroy
    @product.destroy
    redirect_to products_path, status: 303
  end

  private def find_products
    @products = Product.order(id: :asc).with_attached_image
  end

  private def find_product
    @product = Product.find_by(id: params[:id])
    render_not_found if @product.nil?
  end

  private def product_params
    params.require(:product).permit(:name, :price, :image)
  end
end
