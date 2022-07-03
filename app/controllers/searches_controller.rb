class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search_result

    @model = params[:model]
    @content = params[:content]

    if @model == 'User'
      if params[:content].present?
        @users = User.where('name LIKE ?', "%#{params[:content]}%")
      end
    elsif @model == 'CropFolder'
      if params[:content].present?
        @crop_folders = CropFolder.where('crop_name LIKE ?', "%#{params[:content]}%")
      end
    else
      if params[:content].present?
        @items = Item.where('item_name LIKE ?', "%#{params[:content]}%")
      end
    end

  end
end
