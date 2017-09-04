class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
    @users = User.new
    # with the nested attributes
    @users.books.build
  end

  def privacy_policy
  end
end
