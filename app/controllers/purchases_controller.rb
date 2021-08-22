class PurchasesController < ApplicationController

  def index
    @purchase_residence = PurchaseResidence.new
    @item = Item.find(params[:item_id])
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase_residence = PurchaseResidence.new(purchase_params)
    if @purchase_residence.valid?
      @purchase_residence.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def purchase_params
    params.permit(:postal_code, :prefecture_id, :city, :address, :building_name, :phone_num, :item_id).merge(user_id: current_user.id)
  end
end
