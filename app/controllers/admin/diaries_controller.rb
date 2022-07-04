class Admin::DiariesController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    @crop_folder = CropFolder.find(params[:crop_folder_id])
    @diary = Diary.find(params[:id])
    @diary.destroy
    redirect_to admin_crop_folder_path(@crop_folder), success: "日記を削除しました"
  end

end
