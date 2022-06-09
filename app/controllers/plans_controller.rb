class PlansController < ApplicationController

  def index
    @user = current_user
    @plans = @user.plans.all
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(plan_params)
    @plan.user_id = current_user.id
    if @plan.save
      redirect_to plans_path
    else
      @user = current_user
      @plans = @user.plans.all
      render 'index'
    end
  end

  private
   def plan_params
     params.require(:plan).permit(:crop_title, :action, :start_time)
   end
end

