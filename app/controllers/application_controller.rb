class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: %i[index]
  before_action :assign_env_variable

  def assign_env_variable
    gon.stripe_key = ENV['STRIPE_KEY']
  end
end
