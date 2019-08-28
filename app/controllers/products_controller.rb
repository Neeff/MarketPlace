class ProductsController < ApplicationController
  #before_action :set_user, only: %i[create ]
  before_action :set_product, only: %i[show destroy update edit]
  def index
    @products = Product.all
  end

  def create
    @product = Product.create(product_params)
    CategoryProduct.create(product_id: @product.id, category_id: params[:product][:category_id].to_i)
    if @product.persisted?
      flash[:notice] = 'Product Created Whit Success'
      redirect_to root_path
    else
      flash[:alert] = 'Product Not Created. Try Again'
      redirect_to root_path
    end
  end

  def show
    @user = current_user
    respond_to :js
  end

  def destroy
    @product.destroy
    respond_to :js
  end

  def edit
    @user = current_user
    @category = Category.all
    respond_to :js
  end

  def update
    @product.update(product_params)
    if @product.persisted?
      flash[:notice] = 'Product Update Whit Success'
    else
      flash[:alert] = 'Product Not Update Try Again'
    end
    respond_to :js
  end
  private



  def product_params
    params.require(:product).permit(:name, :description,:stock, :price, :user_id, images:[])
  end

  def set_product
    @product = Product.find(params[:id])
  end

end
