class ItemsController < ApplicationController
  def show
    @item = Item.find_by(id: params[:id])
  end

  def index
    @items = Item.all
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    if @item.save
      redirect_to items_path
    else
      @items = Item.all
      render "index"
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to items_path(@item), notice: "商品の登録内容を更新しました"
    else
      render "edit"
    end
  end

private

  def item_params
    params.require(:item).permit(:item_name, :item_count, :sales_method, :sales_area, :introduction, :price, :is_active)
  end


end