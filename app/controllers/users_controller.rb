class UsersController < ApplicationController

  def new
    @user = User.new
    @title = "Sign Up"
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      flash[:success] = "Welcome"
      sign_in @user
      redirect_to @user
    else
      @title = "Sign Up"
      render 'new'
    end
  end

end
