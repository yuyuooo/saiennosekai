class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :quit]
  before_action :ensure_guest_user, only: [:edit, :quit]

  def index
  end

  def show
    @user = User.find(params[:id])
    if @user == current_user
      @crop_folders = @user.crop_folders.order(created_at: :desc).page(params[:page]).per(5)
    else
      @crop_folders = @user.crop_folders.published.order(created_at: :desc).page(params[:page]).per(5)
    end
    @crop_folder = CropFolder.new
  end

  def about
    @user = User.find(params[:id])
  end


  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_about_path(@user), success: "会員情報の登録内容を更新しました"
    else
      render "edit"
    end
  end

  def favorites
    @user = User.find(params[:id])
    @crop_folder = @user.crop_folders.order(created_at: :desc).page(params[:page]).per(5)
    favorites = Favorite.where(user_id: @user.id).pluck(:crop_folder_id)
    @favorite_list = CropFolder.find(favorites)
  end

  def likes
    @user = User.find(params[:id])
    @item = @user.items.order(created_at: :desc).page(params[:page]).per(5)
    likes = Like.where(user_id: @user.id).pluck(:item_id)
    @like_list = Item.find(likes)
  end

  def items
    @user = User.find(params[:id])
    @items = @user.items.order(created_at: :desc).page(params[:page]).per(5)
    @new_item = Item.new
  end
  
  def quit
  end

  def out
    @user = User.find(params[:id])
    @user.update(is_active: false)
    reset_session
    redirect_to root_path, success: "ありがとうございました。またのご利用を心よりお待ちしております。"
  end

private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_about_path(current_user)
    end
  end
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "ゲスト"
      redirect_to user_about_path(current_user) , danger: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end  
end
