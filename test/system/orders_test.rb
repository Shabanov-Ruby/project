require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  setup do
    @order = orders(:one)
  end

  test "visiting the index" do
    visit orders_url
    assert_selector "h1", text: "Orders"
  end

  test "should create order" do
    visit orders_url
    click_on "New order"

    fill_in "Buyout", with: @order.buyout_id
    fill_in "Call request", with: @order.call_request_id
    fill_in "Credit", with: @order.credit_id
    fill_in "Description", with: @order.description
    fill_in "Exchange", with: @order.exchange_id
    fill_in "Installment", with: @order.installment_id
    fill_in "Order status", with: @order.order_status_id
    click_on "Create Order"

    assert_text "Order was successfully created"
    click_on "Back"
  end

  test "should update Order" do
    visit order_url(@order)
    click_on "Edit this order", match: :first

    fill_in "Buyout", with: @order.buyout_id
    fill_in "Call request", with: @order.call_request_id
    fill_in "Credit", with: @order.credit_id
    fill_in "Description", with: @order.description
    fill_in "Exchange", with: @order.exchange_id
    fill_in "Installment", with: @order.installment_id
    fill_in "Order status", with: @order.order_status_id
    click_on "Update Order"

    assert_text "Order was successfully updated"
    click_on "Back"
  end

  test "should destroy Order" do
    visit order_url(@order)
    click_on "Destroy this order", match: :first

    assert_text "Order was successfully destroyed"
  end
end
