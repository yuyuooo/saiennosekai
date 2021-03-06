class FavoritesController < ApplicationController

  def create
    @crop_folder = CropFolder.find(params[:crop_folder_id])
    favorite = current_user.favorites.new(crop_folder_id: @crop_folder.id)
    favorite.save
    @crop_folder.create_notification_favorite!(current_user)
    render 'create'
  end

  def destroy
    @crop_folder = CropFolder.find(params[:crop_folder_id])
    @favorite = current_user.favorites.find_by(crop_folder_id: @crop_folder.id)
    @favorite.destroy
    render 'destroy'
  end

end
