class LikesController < ApplicationController

  def create
    @item = Item.find(params[:item_id])
    like = current_user.likes.new(item_id: @item.id)
    like.save
    @item.create_notification_like!(current_user)
  end

  def destroy
    @item = Item.find(params[:item_id])
    like = current_user.likes.find_by(item_id: @item.id)
    like.destroy
  end

end
