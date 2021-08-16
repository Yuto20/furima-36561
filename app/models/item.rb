class Item < ApplicationRecord

  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_charge
  belongs_to :delivery_area
  belongs_to :delivery_day

  with_options presence: true do
    validates :product_name
    validates :description
    validates :category_id,        numericality: { other_than: 1 , message: "can't be blank"}
    validates :status_id,          numericality: { other_than: 1 , message: "can't be blank"}
    validates :delivery_charge_id, numericality: { other_than: 1 , message: "can't be blank"}
    validates :delivery_area_id,   numericality: { other_than: 1 , message: "can't be blank"}
    validates :delivery_day_id,    numericality: { other_than: 1 , message: "can't be blank"}
    validates :price,              numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
    validates :image
  end
  
end