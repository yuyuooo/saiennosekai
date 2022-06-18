class CropCommentsController < ApplicationController

  def create
    crop_folder = CropFolder.find(params[:crop_folder_id])
    comment = current_user.crop_comments.new(crop_comment_params)
    comment.crop_folder_id = crop_folder.id
    comment.save
    redirect_to crop_folder_path(crop_folder)
  end

  private

  def crop_comment_params
    params.require(:crop_comment).permit(:comment)
  end
end
