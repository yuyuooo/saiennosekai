class DiariesController < ApplicationController

before_action :authenticate_user!

  def create
    @crop_folder = CropFolder.find(params[:crop_folder_id])
    @diary = current_user.diaries.new(diary_params)
    @diary.crop_folder_id = @crop_folder.id
    if @diary.save
      redirect_to crop_folder_path(@crop_folder.id)
    else
      render 'crop_folders/show'
    end
  end

  def edit
  end

  def destroy
  end

private

  def diary_params
    params.require(:diary).permit(:diary_date, :weather, :title, :crop_image, :body)
  end

end
