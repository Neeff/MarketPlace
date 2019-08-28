class ProfilesController < ApplicationController
  before_action :info, :last_fourt_digits, only: %i[dashboard add_credit_card]
  def dashboard; end

  def add_product
    @user = current_user
    @category = Category.all
    @product = Product.new
  end

  def add_credit_card
    @user = current_user
  end

  def my_products
    @products = current_user.products.order(:name).page(params[:page])
    @user = current_user
    @category = Category.all
    @product = params[:id]
  end

  def orders
    @orders = Transaction.where(user_id: current_user).order(created_at: :desc).page(params[:page])
  end
  private

  def info
    @info = current_user.customer_info
  end

  def last_fourt_digits
    @info = current_user.customer_info
    @last_digits =  @info.sources.data[0].last4
  end
end
