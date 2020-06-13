class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user,only: [:edit]

  def new
  	@book = Book.new
  end

  def create
  	@newbook = Book.new(book_params)
    @newbook.user_id = current_user.id
  	if @newbook.save
      flash[:notice] = "Book was successfully created."
  	  redirect_to book_path(@newbook.id)
    else
      @books = Book.all
      @user = User.find(current_user.id)
      render :index
    end
  end

  def index
    @newbook = Book.new
  	@books = Book.all
    @user = current_user
  end

  def show
  	@newbook = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:notice] = "Book was successfully deleted."
    redirect_to books_path
  end

  private
  def book_params
  	  params.require(:book).permit(:title, :body)
  end
  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    if @user.id != current_user.id
      redirect_to books_path
    end
  end
end
