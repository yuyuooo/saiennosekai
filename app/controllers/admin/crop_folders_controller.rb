class Admin::CropFoldersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @crop_folder = CropFolder.find(params[:id])
    #@crop_comment = CropComment.new
    @user = User.find_by(id: params[:id])
  end

  def destroy
    @crop_folder = CropFolder.find(params[:id])
    @crop_folder.destroy
    redirect_to admin_user_path(@crop_folder.user), success: "栽培作物を削除しました"
  end
end
