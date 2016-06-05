class BooksController < ApplicationController
    def index
      @books = Book.all
    end
   
    def show
      @book = Book.find(params[:id])
    end
   
    def new
      @book = Book.new
    end
   
    def edit
      @book = Book.find(params[:id])
    end
   
    def create
      @book = Book.new(book_params)
   
      if @book.save
        redirect_to books_path
      else
        render 'new'
      end
    end
   
    def update
      @book = Book.find(params[:id])
   
      if @book.update(book_params)
        redirect_to books_path
      else
        render 'edit'
      end
    end
   
    def destroy
      @book = Book.find(params[:id])
      @book.destroy
   
      redirect_to books_path
    end

    def haha
      @book = Book.new
    end
   
    private
      def book_params
        params.require(:book).permit(:book_isbn, :book_title, :book_author, :book_status, :book_edition, :book_image)
      end
end