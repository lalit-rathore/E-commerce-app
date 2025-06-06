class OrdersController < ApplicationController
    def create
        cart = current_user.cart
        order = Order.create(user: current_user, total: cart_total(cart))

        cart.cart_items.each do |item|
            OrderItem.create(order: order, product: item.product, quantity: item.quantity, price: item.product.price)
        end

        if cart.cart_items.exists?
            cart.cart_items.destroy_all
            redirect_to order_path(order), notice: 'Order Placed'
        else
            redirect_to products_path, alert: "your Cart is empty"
        end
    end

    def show
        @order = Order.find(params[:id])
    end

    private

    def cart_total(cart)
        cart.cart_items.sum {|item| item.product.price * item.quantity }
    end
end
