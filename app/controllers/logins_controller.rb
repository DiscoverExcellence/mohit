class LoginsController < ApplicationController

  def show
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:user][:email])
    if !@user.nil? and @user.authenticate(params[:user][:password])
      flash[:notice] = "You have successfully login!!!"
      redirect_to :root
    else
      flash[:error] = "Login Failed !!! Invalid Username or Password"
      @user = User.new
      render :show
    end
  end
end
