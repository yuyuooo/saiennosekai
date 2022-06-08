class DiariesController < ApplicationController
 
before_action :authenticate_user!
  
  def create
    @crop_folder = CropFolder.find(params[:crop_folder_id])
    @diary = current_user.diaries.new(diary_params)
    @diary.crop_folder_id = crop_folder_id
    if @diary.save
      redirect_to request.referer
    else
      render 'crop_folder_path'
    end
  end
  
  def edit
  end
  
  def destroy
  end
  
private

  def diary_params
    params.require(:diary).permit(:crop_name, :place, :memo, :new_crop_date)
  end
  
end
