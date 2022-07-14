class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @item = Item.new
  end

  def show
    @item = Item.find_by(id: params[:id])
  end

  def index
    @item = Item.new
    if params[:latest]
      @items = Item.latest.page(params[:page]).per(5)
    elsif params[:old]
      @items = Item.old.page(params[:page]).per(5)
    elsif params[:like_count]
      @items = Item.includes(:likes).sort {|a,b| b.likes.size <=> a.likes.size}
      @items = Kaminari.paginate_array(@items).page(params[:page]).per(5)
    else
      @items = Item.all.order(created_at: :desc).page(params[:page]).per(5)
    end
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    if @item.save
      redirect_to user_items_path(@item.user), success: "栽培作物を投稿しました"
    else
      @items = Item.all.order(created_at: :desc).page(params[:page]).per(5)
      render "new"
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to user_items_path(@item.user), success: "商品の登録内容を更新しました"
    else
      render "edit"
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to user_items_path(@item.user), success: "栽培作物を削除しました"
  end

private

  def item_params
    params.require(:item).permit(:item_name, :item_count, :sales_method, :sales_area, :introduction, :price, :is_active, :item_image)
  end

  def ensure_correct_user
    @item = Item.find(params[:id])
    unless @item.user == current_user
      redirect_to items_path
    end
  end

end