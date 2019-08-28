module ApplicationHelper
  def stripe_url
    "https://connect.stripe.com/oauth/authorize?response_type=code&client_id=#{ENV['STRIPE_CONNECT_CLIENT_ID']}&scope=read_write"
  end

  def product_name(id)
    Product.find(id).name
  end
end
