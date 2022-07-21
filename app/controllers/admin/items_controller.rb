class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @items = Item.all.order(created_at: :desc).page(params[:page]).per(5)
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to request.referer, notice: "商品を削除しました"
  end

end
