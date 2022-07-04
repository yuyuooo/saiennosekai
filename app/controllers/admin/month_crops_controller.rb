class Admin::MonthCropsController < ApplicationController
  before_action :authenticate_admin!

  def new
    @month_crop = MonthCrop.new
  end

  def create
    @month_crop = MonthCrop.new(month_crop_params)
    if @month_crop.save
      redirect_to admin_month_crops_path, success: "今月のおすすめ作物を投稿しました"
    else
      render 'new'
    end
  end

  def index
    @month_crops = MonthCrop.all
  end

  def show
    @month_crop = MonthCrop.find(params[:id])
  end

  def edit
    @month_crop = MonthCrop.find(params[:id])
  end

  def update
    @month_crop = MonthCrop.find(params[:id])
  end

  def destroy
    @month_crop = MonthCrop.find(params[:id])
    @month_crop.destroy
    redirect_to request.referer, success: "月のおすすめ栽培を削除しました"
  end

private

  def month_crop_params
    params.require(:month_crop).permit(:month, :crop_name, :harvest_time, :introduction, :method, :is_published_flag, :crop_image)
  end

end
