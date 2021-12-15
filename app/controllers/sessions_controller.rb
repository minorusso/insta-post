class SessionsController < ApplicationController
  skip_before_action :login_required, only: %i[new create]
  def new; end

  def create
    # パスワードとメールアドレスの組み合わせが有効かどうか判定することです。
    # この判定によって、有効ならログインする、有効でない場合は再入力させるという次の動作
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end
end
