class UsersController < ApplicationController
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

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
