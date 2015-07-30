class LoginsController < ApplicationController

  def index
    @user = User.new
  end

  def create
    @user = User.authenticate(allow_params)
    if @user
      flash[:notice] = "You have successfully login!!!"
      redirect_to :root
    else
      flash[:error] = "Login Failed !!! Invalid Username or Password"
      @user = User.new
      render :index
    end
  end

  private
  def allow_params
    params.require(:user).permit(:email, :password)
  end

end
