class Product < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :price, presence: true
  validates :price, numericality: {greater_than: 1}
  validates :description, length: {maximum: 500}
  belongs_to :supplier
  has_many :images
  has_many :category_products
  has_many :categories, through: :category_product #do we need this?
  has_many :carted_products

  def sale_message
    if price.to_i < 15
      return "Discount Item!"
    else
      return "Regular Price"
    end
  end

  def cheap?
    if sale_message == "Discount Item!"
      return true
    else
      return false
    end
  end

  def sale_item_class
    if sale_message == "Discount Item!"
      return "discount-item"
    else
      return ""
    end
  end

  def tax
    return price.to_f * 0.09
  end

  def total
    return tax.to_f + price.to_f
  end
end
