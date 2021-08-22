require 'rails_helper'

RSpec.describe PurchaseResidence, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchase_residence = FactoryBot.build(:purchase_residence, user_id: user.id, item_id: item.id)
  end

  context '商品購入記録を保存できる場合' do
    it '全ての値が正しく入力されていれば保存できる' do
      expect(@purchase_residence).to be_valid
    end
    it 'building_nameは空でも保存できる' do
      @purchase_residence.building_name = ''
      expect(@purchase_residence).to be_valid
    end
  end

  context '商品購入記録を保存できない場合' do
    it 'postal_codeが空だと保存できない' do
      @purchase_residence.postal_code = ''
      @purchase_residence.valid?
      expect(@purchase_residence.errors.full_messages).to include("Postal code can't be blank")
    end
    it 'prefecture_idが未選択だと保存できない' do
      @purchase_residence.prefecture_id = ''
      @purchase_residence.valid?
      expect(@purchase_residence.errors.full_messages).to include("Prefecture can't be blank")
    end
    it 'cityが空だと保存できない' do
      @purchase_residence.city = ''
      @purchase_residence.valid?
      expect(@purchase_residence.errors.full_messages).to include("City can't be blank")
    end
    it 'addressが空だと保存できない' do
      @purchase_residence.address = ''
      @purchase_residence.valid?
      expect(@purchase_residence.errors.full_messages).to include("Address can't be blank")
    end
    it 'phone_numが空だと保存できない' do
      @purchase_residence.phone_num = ''
      @purchase_residence.valid?
      expect(@purchase_residence.errors.full_messages).to include("Phone num can't be blank")
    end
    it 'postal_codeが全角文字列だと保存できない' do
      @purchase_residence.postal_code = '１２３-４５６７'
      @purchase_residence.valid?
      expect(@purchase_residence.errors.full_messages).to include("Postal code Input correctly")
    end
    it 'postal_codeにハイフンがないと保存できない' do
      @purchase_residence.postal_code = '1234567'
      @purchase_residence.valid?
      expect(@purchase_residence.errors.full_messages).to include("Postal code Input correctly")
    end
    it 'prefecture_idが0だと保存できない' do
      @purchase_residence.prefecture_id = 0
      @purchase_residence.valid?
      expect(@purchase_residence.errors.full_messages).to include("Prefecture must be other than 0")
    end
    it 'phone_numが全角数値だと保存できない' do
      @purchase_residence.phone_num = '０９０１２３４５６７８'
      @purchase_residence.valid?
      expect(@purchase_residence.errors.full_messages).to include("Phone num Input only number")
    end
    it 'phone_numが10桁未満だと保存できない' do
      @purchase_residence.phone_num = '090123456'
      @purchase_residence.valid?
      expect(@purchase_residence.errors.full_messages).to include("Phone num Input only number")
    end
    it 'phone_numが12桁以上だと保存できない' do
      @purchase_residence.phone_num = '090123456789'
      @purchase_residence.valid?
      expect(@purchase_residence.errors.full_messages).to include("Phone num Input only number")
    end
  end
end