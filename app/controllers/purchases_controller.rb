class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :get_item_params

  def index
    @purchase_residence = PurchaseResidence.new
    redirect_to root_path if current_user == @item.user || @item.purchase.present?
  end

  def create
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

  def get_item_params
    @item = Item.find(params[:item_id])
  end

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
