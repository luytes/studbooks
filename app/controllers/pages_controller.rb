class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
    @book = Book.new
    @user = User.new
  end

  def privacy_policy
  end
end
