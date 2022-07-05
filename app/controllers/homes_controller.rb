class HomesController < ApplicationController
  def top
    @user = User.find_by(id: params[:id])
  end
  
  def month_crop
    @month_crops = MonthCrop.published
  end
  
end
