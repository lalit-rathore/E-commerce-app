class DashboardsController < ApplicationController
  def index
    @order_count = Order.count
    @recent_product = Product.order(created_at: :desc).limit(5)
    @user =User.all
    @order =Order.all
  end
end
