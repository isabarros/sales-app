# frozen_string_literal: true

require 'test_helper'

class SalesControllerTest < ActionController::TestCase
  setup do
    organization = Organization.create!(name: "Test Organization")

    users = 3.times.map { User.create!(name: FFaker::Name.name, email: FFaker::Internet.email) }

    @sales_reps = users.each_with_index.map do |user, index|
      SalesRep.create!(user: user, organization:)
    end

    @product_a = Product.create!(name: "Product A", price: 50)
    @product_b = Product.create!(name: "Product B", price: 20)
    product_c = Product.create!(name: "Product C", price: 10)
    Product.create!(name: "Product D", price: 5)

    @sales_reps.each do |sales_rep|
      sale = Sale.create!(sales_rep: sales_rep)

      Item.create!(sale: sale, product: @product_a, quantity: 3)
      Item.create!(sale: sale, product: @product_b, quantity: 2)
      Item.create!(sale: sale, product: product_c, quantity: 1)
    end

    other_user = User.create!(name: FFaker::Name.name, email: FFaker::Internet.email)
    other_sales_rep = SalesRep.create!(user: other_user, organization:)
    other_sale = Sale.create!(sales_rep: other_sales_rep)
    Item.create!(sale: other_sale, product: Product.create!(name: "Other Product", price: 100), quantity: 5)
  end

  test "should assign total number of Sales Reps for the organization" do
    sale = Sale.create!(sales_rep: @sales_reps.first)
    Item.create!(sale:, product: @product_a, quantity: 3)
    Item.create!(sale:, product: @product_b, quantity: 5)

    get :show, params: { id: sale.id }

    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal sale.id, json_response['id']

    expected_products = [
      { "name" => @product_a.name, "quantity" => 3 },
      { "name" => @product_b.name, "quantity" => 5 }
    ]

    assert_equal expected_products, json_response['products']
  end
end
