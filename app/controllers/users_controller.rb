class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user,only: [:edit]

  def show
    @newbook = Book.new
  	@user = User.find(params[:id])
  	@books = @user.books
  end

  def index
    @users = User.all
    @user = User.find(current_user.id)
    @newbook = Book.new
    @book = Book
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private
    def user_params
  	  params.require(:user).permit(:name, :introduction, :profile_image)
    end
    def correct_user
      @user = User.find(params[:id])
      if @user.id != current_user.id
      redirect_to user_path(current_user.id)
    end
  end

end
