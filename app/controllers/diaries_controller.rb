class DiariesController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @crop_folder = CropFolder.find(params[:crop_folder_id])
    @diary = Diary.new
  end

  def create
    @crop_folder = CropFolder.find(params[:crop_folder_id])
    @diary = current_user.diaries.new(diary_params)
    @diary.crop_folder_id = @crop_folder.id
    if @diary.save
      redirect_to crop_folder_path(@crop_folder.id), success: "栽培日記を登録しました"
    else
      @crop_comment = CropComment.new
      render 'crop_folders/show'
    end
  end

  def destroy
    @crop_folder = CropFolder.find(params[:crop_folder_id])
    @diary = Diary.find(params[:id])
    @diary.destroy
    redirect_to crop_folder_path(@crop_folder), success: "日記を削除しました"
  end

private

  def diary_params
    params.require(:diary).permit(:diary_date, :weather, :title, :crop_image, :body)
  end

end
