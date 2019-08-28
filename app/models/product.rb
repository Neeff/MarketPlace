class Product < ApplicationRecord
  paginates_per 15
  belongs_to :user
  has_many_attached :images
  has_many :category_products, dependent: :destroy
  has_many :categories, through: :category_products
  has_many :transactions
  validates :name, :description, presence: true
  validates :stock, numericality: { only_integer: true }
  validates :price, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0, less_than: 1_000_000 }
end
