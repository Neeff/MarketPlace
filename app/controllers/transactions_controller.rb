class TransactionsController < ApplicationController

  def make_transaction(product)
    @transaction = Transaction.create(total: product.price.to_i, user_id: current_user.id, shop_id: product.user.id, product_id: product.id)
   end

  def create
    product = Product.find(params[:product_id])
    shop_id = product.user.uid

    charge = Stripe::Charge.create({
            amount: product.price.to_i,
            currency: 'USD',
            customer: current_user.stripe_customer_id,
            description: '**************',
            destination: shop_id

    })
    make_transaction(product)
    @transaction.update(paid: true, stripe_charge: charge.id) if charge.paid?
    begin
  # Use Stripe's library to make requests...
    rescue Stripe::CardError => e
  # Since it's a decline, Stripe::CardError will be caught
   body = e.json_body
    err  = body[:error]

  puts "Status is: #{e.http_status}"
  puts "Type is: #{err[:type]}"
  puts "Charge ID is: #{err[:charge]}"
  # The following fields are optional
  puts "Code is: #{err[:code]}" if err[:code]
  puts "Decline code is: #{err[:decline_code]}" if err[:decline_code]
  puts "Param is: #{err[:param]}" if err[:param]
  puts "Message is: #{err[:message]}" if err[:message]
rescue Stripe::RateLimitError => e
  # Too many requests made to the API too quickly
rescue Stripe::InvalidRequestError => e
  # Invalid parameters were supplied to Stripe's API
rescue Stripe::AuthenticationError => e
  # Authentication with Stripe's API failed
  # (maybe you changed API keys recently)
rescue Stripe::APIConnectionError => e
  # Network communication with Stripe failed
rescue Stripe::StripeError => e
  # Display a very generic error to the user, and maybe send
  # yourself an email
rescue => e
  # Something else happened, completely unrelated to Stripe
end
    respond_to :js
   end
end
