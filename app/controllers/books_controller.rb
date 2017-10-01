class BooksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :sortable]
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @title = params.dig("book", "title")
    @university = params.dig("users", "university")
    # Using present? method
    # if params[:book][:title].present? && params[:users][:university].present?
    #   @books = Book.where({title: params[:book][:title]})
    #   .joins(:user).where(users: {university: params[:users][:university]})
    # elsif !params[:users][:university].present? && params[:book][:title].present?
    #   @books = Book.where({title: params[:book][:title]})
    # elsif params[:users][:university].present? && !params[:book][:title].present?
    #   @books = Book.joins(:user).where(users: {university: params[:users][:university]})
    # else
    #   @books = Book.all
    # end

    # Using the DIG method
    # The dig method won't look further if a key is nil, which avoids this kind of error.
    # if params.dig("book", "title").nil? && params.dig("users", "university").nil?
    #   @books = Book.where({title: params.dig("book", "title")})
    #   .joins(:user).where(users: {university: params.dig("users", "university")})
    # elsif !params.dig("book", "title").nil? && params.dig("users", "university").nil?
    #   @books = Book.where({title: params.dig("book", "title")})
    # elsif params.dig("book", "title").nil? && !params.dig("users", "university").nil?
    #   @books = Book.joins(:user).where(users: {university: params.dig("users", "university")})
    # else
    #   @books = Book.all
    # end

    # Using the == "" method
    if (params.dig("book", "title") != "" ) && (params.dig("users", "university") != "" )
      @books = Book.where({title: params.dig("book", "title")})
      .joins(:user).where(users: {university: params.dig("users", "university")})
    elsif (params.dig("book", "title") != "" ) && (params.dig("users", "university") == "" )
      @books = Book.where({title: params.dig("book", "title")})
    elsif (params.dig("book", "title") == "" ) && (params.dig("users", "university") != "" )
      @books = Book.joins(:user).where(users: {university: params.dig("users", "university")})
    else
      @books = Book.all
    end

    case params[:sort]
      when "Price Descending"
        if (params[:title] != "" ) && (params[:university] != "" )
          @books = Book.where({title: params[:title]})
          .joins(:user).where(users: {university: params[:university]}).order(price_cents: "DESC")
        elsif (params[:title] != "" ) && (params[:university] == "" )
          @books = Book.where({title: params[:title]}).order(price_cents: "DESC")
        elsif (params[:title] == "" ) && (params[:university] != "" )
          @books = Book.joins(:user).where(users: {university: params[:university]}).order(price_cents: "DESC")
        else
          @books = Book.all.order(price_cents: "DESC")
        end
      when "Price Ascending"
        if (params[:title] != "" ) && (params[:university] != "" )
          @books = Book.where({title: params[:title]})
          .joins(:user).where(users: {university: params[:university]}).order(price_cents: "ASC")
        elsif (params[:title] != "" ) && (params[:university] == "" )
          @books = Book.where({title: params[:title]}).order(price_cents: "ASC")
        elsif (params[:title] == "" ) && (params[:university] != "" )
          @books = Book.joins(:user).where(users: {university: params[:university]}).order(price_cents: "ASC")
        else
          @books = Book.all.order(price_cents: "ASC")
        end
      when "Best Results"
        if (params[:title] != "" ) && (params[:university] != "" )
          @books = Book.where({title: params[:title]})
          .joins(:user).where(users: {university: params[:university]}).sort_by(&:created_at)
        elsif (params[:title] != "" ) && (params[:university] == "" )
          @books = Book.where({title: params[:title]}).sort_by(&:created_at)
        elsif (params[:title] == "" ) && (params[:university] != "" )
          @books = Book.joins(:user).where(users: {university: params[:university]}).sort_by(&:created_at)
        else
          @books = Book.all.sort_by(&:created_at)
        end
    end
    @publish_year = @books.map { |p| p.publish_year }.uniq
    @condition = @books.map { |c| c.condition }.uniq
    respond_to do |format|
      format.html
      format.json { render json: @books }
    end
    # render json: {data: @books}
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

  def sort_order
    params[:sort] == "Price Descending" ? "desc" : "asc"
  end

  def sortable
    sort = params[:sort]
    case sort
      when "Best Results"
        @books = @books.price_cents.sort_by(&:created_at)
      when "Price Descending"
        @books = @books.order(price_cents: :desc)
      when "Price Ascending"
        @books = @books.order(price_cents: :asc)
    end
  end

end
