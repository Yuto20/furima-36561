class PurchasesController < ApplicationController

  def index
    @purcahse_residence = PurchaseResidence.new
  end

  def create
    @purcahse_residence = PurchaseResidence.new(purcahse_params)
    if @purcahse_residence.valid?
      @purcahse_residence.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def purcahse_params
    binding.pry
    params.permit(:postal_code, :prefecture_id, :city, :address, :building_name, :phone_num, :item_id).merge(user_id: current_user.id)
  end
end
