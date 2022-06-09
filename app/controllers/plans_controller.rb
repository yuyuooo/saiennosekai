class PlansController < ApplicationController

  def index
    @plans = Plan.all
    @plan = Plan.new
    @plan.user_id = current_user.id
  end

  def create
    @plan = Plan.new(plan_params)
    @plan.save
    redirect_to plans_path
  end

  private
   def plan_params
     params.require(:plan).permit(:crop_title, :action, :start_time)
   end
end

