class Admin::DashboardsController < ApplicationController
  def index
    @order_count = Order.count
    @recent_product = Product.all
    @user =User.all
    @order =Order.all
  end

end
