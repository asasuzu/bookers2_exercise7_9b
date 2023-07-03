class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @today_book = @books.created_today
    @yesterday_book = @books.created_yesterday
    # @days2_ago_book = @books.created_2days_ago
    # @days3_ago_book = @books.created_3days_ago
    # @days4_ago_book = @books.created_4days_ago
    # @days5_ago_book = @books.created_5days_ago
    # @days6_ago_book = @books.created_6days_ago
    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week
  end

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render 'edit'
    end
  end
  
   # フォロー一覧
  def followings
    user = User.find(params[:id])
    @users = user.followings
  end
  # フォロワー一覧
  def followers
    user = User.find(params[:id])
    @users = user.followers
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end

