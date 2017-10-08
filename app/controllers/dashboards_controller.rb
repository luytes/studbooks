class DashboardsController < ApplicationController
  def show
    @user = current_user
    # if @user.profile_picture.nil?
    #   @user.profile_picture = "chemie.jpg"
    # end
    # @students = Student.all
    # @enquires = Enquire.all
    # @orders = Order.all
    # @order = Order.where(state: 'active') # gives me all the active orders
    # @hash = @order.where(customer: @user.customer_id).map do |hash|
    #   hash.service #creates an array of SERVICE objects
    # end
    # @surveys = Survey.all

    # if @user.admin == true
    #   @services = Service.all
    # else
    #   @services = @hash
    # end
  end

  private
end
