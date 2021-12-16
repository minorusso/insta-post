class UsersController < ApplicationController
  skip_before_action :login_required, only: %i[new create]
  # before_action :authenticate_user, { only: %i[edit update] }
  before_action :ensure_correct_user, { only: %i[edit update] }
  def new
    @user = User.new
  end

  def create
    # ユーザがフォームに入力した値でUserモデルの新しいインスタンスを生成する
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to users_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = '情報を編集しました！'
      redirect_to user_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :image, :image_cache)
  end

  def ensure_correct_user
    redirect_to blogs_path unless current_user.id == @user.id
  end
end
