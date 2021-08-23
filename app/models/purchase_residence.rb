class PurchaseResidence
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building_name, :phone_num, :user_id, :item_id, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'Input correctly' }
    validates :prefecture_id, numericality: { other_than: 0, allow_blank: true }
    validates :city
    validates :address
    validates :phone_num, format: { with: /\A\d{10,11}\z/, message: 'Input only number' }
    validates :user_id
    validates :item_id
    validates :token
  end

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Residence.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address,
                     building_name: building_name, phone_num: phone_num, purchase_id: purchase.id)
  end
end
