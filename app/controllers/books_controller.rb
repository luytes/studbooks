class BooksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = Book.all
    # if params[:book][:title].present? && params[:user][:country].present? && params[:user][:university].present?
    #   @books = Book.where({title: params[:book][:title]})
    #   .joins(:user).where(user: {country: params[:user][:country].titleize}).uniq
    # else
    #   @books = Book.where({title: params[:book][:title]}).uniq
    # end
  end

  def show
    @user = current_user
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      render :new
    else
      redirect_to new_book_path
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    respond_to do |format|
      format.js do
        redirect_to dashboard_path, notice: "Successfully Deleted"
      end
      format.html do
        redirect_to dashboard_path
      end
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :field,
                                 :iban, :publish_year, :picture, :price_cents,
                                 :price_currency, :condition, :state)
  end
end
