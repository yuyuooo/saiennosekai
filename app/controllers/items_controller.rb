class ItemsController < ApplicationController
  def show

  end

  def index
    @items = Item.all
    @item = Item.new
  end

  def create
  end

private

  def item_params
    params.require(:item).permit(:item_name, :item_count, :salse_method, :salse_area, :introduction, :price)
  end


end