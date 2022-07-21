class Admin::CropFoldersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @crop_folders = CropFolder.all.order(created_at: :desc).page(params[:page]).per(5)
  end

  def show
    @crop_folder = CropFolder.find(params[:id])
    @user = User.find_by(id: params[:id])
  end

  def destroy
    @crop_folder = CropFolder.find(params[:id])
    @crop_folder.destroy
    redirect_to request.referer, notice: "栽培作物を削除しました"
  end
end
