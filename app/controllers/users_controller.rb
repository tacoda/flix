class UsersController < ApplicationController
  # Order matters!
  # methods are executed in turn starting at the top and working down
  before_action :require_signin, except: [ :new, :create ]
  before_action :require_correct_user, only: [ :edit, :update, :destroy ]

  def index
    @users = User.not_admins
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
    @favorite_movies = @user.favorite_movies
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "Thanks for signing up!"
    else
    # TODO: Flash errors
    render :new
    end
  end

  def edit
  end

  def update
      if @user.update(user_params)
        redirect_to @user, notice: "Account successfully updated!"
      else
        render :edit
      end
    end

    def destroy
      @user.destroy
      session[:user_id] = nil
      redirect_to movies_url, alert: "Account successfully deleted!"
    end

  private

  def user_params
    params.require(:user).
      permit(:name, :email, :password, :password_confirmation)
  end

  def require_correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless current_user?(@user)
    end
end
