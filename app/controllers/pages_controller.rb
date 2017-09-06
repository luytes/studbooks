class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
    @books = Book.new
    # with the nested attributes
    # @books.user.build
  end

  def privacy_policy
  end
end
