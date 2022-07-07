class Admin::CropCommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    @crop_folder = CropFolder.find(params[:crop_folder_id])
    @crop_comment = CropComment.find(params[:id])
    @crop_comment.destroy
    redirect_to admin_crop_folder_path(@crop_folder), success: "コメントを削除しました"
  end
end
