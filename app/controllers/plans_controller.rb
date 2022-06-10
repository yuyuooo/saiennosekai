class PlansController < ApplicationController

  def index
    @user = current_user
    @plans = @user.plans.all
    @plan = Plan.new
    @crop_folders = @user.crop_folders.all
  end

  def show
    @crop_folder = CropFolder.find_by(id: params[:crop_folder_id])
    @plan = Plan.new
  end

  def create
    @crop_folder = CropFolder.find(params[:crop_folder_id])
    @plan = current_user.plans.new(plan_params)
    @plan.crop_folder_id = @crop_folder.id
    if @plan.save
      redirect_to crop_folder_plans_path(@crop_folder.id)
    else
      render 'show'
    end
  end

  private
   def plan_params
     params.require(:plan).permit(:crop_title, :action, :start_time)
   end
end

