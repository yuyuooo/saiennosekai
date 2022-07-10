class CropCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @crop_folder = CropFolder.find(params[:crop_folder_id])
    @crop_comment = current_user.crop_comments.new(crop_comment_params)
    @crop_comment.crop_folder_id = @crop_folder.id
    @comment_crop = @crop_comment.crop_folder
    @crop_comment.save
    unless @crop_comment.save
      render 'validater'
    end
    @comment_crop.create_notification_comment!(current_user, @crop_comment.id)
  end

  private

  def crop_comment_params
    params.require(:crop_comment).permit(:comment)
  end
end
