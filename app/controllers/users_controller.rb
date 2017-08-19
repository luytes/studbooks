class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]
  before_action :set_user, only: [:show, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def edit
    @user = current_user
  end

  def update
    user_params
    @user = current_user
    @user.update(user_params)
    if @user.save!
      redirect_to dashboard_path(@user)
    else
      render 'new'
    end
  end

  def confirm_email
    @user = User.find_by_confirm_token(params[:id])
    if @user
      @user.email_activate
      flash[:success] = "Welcome to Studbooks! Your email has been confirmed."
      redirect_to dashboard_path
    else
      flash[:error] = "Sorry. User does not exist"
      redirect_to root_url
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:picture, :picture_cache,
                                 :email, :password, :first_name, :last_name,
                                 :university, :age, :gender, :country,
                                 :email_confirmed, :confirm_token)
  end

  def destroy
    @user.destroy
  end
end
