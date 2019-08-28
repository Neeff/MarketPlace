class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable,
         omniauth_providers: %i[stripe_connect]
  has_many :products
  has_many :transactions

  def can_receive_payments?
    uid? && provider? && access_code? && publishable_key?
  end

  def customer_info
    unless stripe_customer_id.nil?
      Stripe::Customer.retrieve(stripe_customer_id)
    end
  end

  def stripe_customer_id?
    if stripe_customer_id.nil?
      false
    else
      true
    end
  end
end
