class BooksController < ApplicationController
    def index
      @current_user = User.find session[:user_id]
      @books = Book.all
    end
   
    def show
      @current_user = User.find session[:user_id]
      @book = Book.find(params[:id])
    end
   
    def new
      @current_user = User.find session[:user_id]
      
      @book = Book.new
    end
   
    def edit
      #@current_user = User.find_by_id("1")
      @current_user = User.find session[:user_id]
      @book = Book.find(params[:id])
    end
   
    def create
      @current_user = User.find session[:user_id]
      @book = Book.new(book_params)
   
      if @book.save
        redirect_to books_path
      else
        render 'new'
      end
    end
   
    def update
      @current_user = User.find session[:user_id]
      @book = Book.find(params[:id])
   
      if @book.update(book_params)
        redirect_to books_path
      else
        render 'edit'
      end
    end
   
    def destroy
      @current_user = User.find session[:user_id]
      @book = Book.find(params[:id])
      @book.destroy
   
      redirect_to books_path
    end
   
    private
      def book_params
        params.require(:book).permit(:book_isbn, :book_title, :book_author, :book_status, :book_edition, :book_image)
      end
end