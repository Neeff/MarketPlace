class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :product
  paginates_per 10
end
