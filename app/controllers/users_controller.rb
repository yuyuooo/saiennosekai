class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
    @crop_folders = @user.crop_folders
    @crop_folder = CropFolder.new
  end
end
