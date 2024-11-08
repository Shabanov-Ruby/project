require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get orders_url
    assert_response :success
  end

  test "should get new" do
    get new_order_url
    assert_response :success
  end

  test "should create order" do
    assert_difference("Order.count") do
      post orders_url, params: { order: { buyout_id: @order.buyout_id, call_request_id: @order.call_request_id, credit_id: @order.credit_id, description: @order.description, exchange_id: @order.exchange_id, installment_id: @order.installment_id, order_status_id: @order.order_status_id } }
    end

    assert_redirected_to order_url(Order.last)
  end

  test "should show order" do
    get order_url(@order)
    assert_response :success
  end

  test "should get edit" do
    get edit_order_url(@order)
    assert_response :success
  end

  test "should update order" do
    patch order_url(@order), params: { order: { buyout_id: @order.buyout_id, call_request_id: @order.call_request_id, credit_id: @order.credit_id, description: @order.description, exchange_id: @order.exchange_id, installment_id: @order.installment_id, order_status_id: @order.order_status_id } }
    assert_redirected_to order_url(@order)
  end

  test "should destroy order" do
    assert_difference("Order.count", -1) do
      delete order_url(@order)
    end

    assert_redirected_to orders_url
  end
end
