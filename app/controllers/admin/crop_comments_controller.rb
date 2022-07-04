class Admin::CropCommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    CropComment.find(params[:id]).destroy
    redirect_to request.referer, success: "コメントを削除しました。"
  end
end
