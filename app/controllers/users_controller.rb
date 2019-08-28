class UsersController < ApplicationController
  def update
    @user = current_user
    stripe_temporary_token = params[:user][:stripe_temporary_token]
    unless stripe_temporary_token.nil?
      customer = Stripe::Customer.create(email: @user.email, source: stripe_temporary_token)
      @user.update_attribute(:stripe_customer_id, customer.id)
    end
    if @user.stripe_customer_id.present?
      flash[:notice] = 'Credit Card Associated with success'
      redirect_to add_credit_card_path
    else
      flash[:alert] = 'ERROR Credit Card not Associated'
      redirect_to add_credit_card_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email,
                                 :stripe_customer_id,
                                 :stripe_temporary_token,
                                 :provider,
                                 :uid,
                                 :publishable_key,
                                 :access_code)
  end
end
