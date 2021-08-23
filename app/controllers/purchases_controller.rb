class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: :index

  def index
    @purchase_residence = PurchaseResidence.new
    @item = Item.find(params[:item_id])
    redirect_to root_path if current_user == @item.user
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase_residence = PurchaseResidence.new(purchase_params)
    if @purchase_residence.valid?
      pay_item
      @purchase_residence.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_residence).permit(:postal_code, :prefecture_id, :city, :address, :building_name, :phone_num).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end
end
