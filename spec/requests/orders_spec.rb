require 'rails_helper'

RSpec.describe "Orders", type: :request do
  let(:customer) { FactoryBot.create(:customer) }
  let(:valid_attributes) { { product_name: "Sample Product", product_count: 5, customer_id: customer.id } }
  let(:invalid_attributes) { { product_name: nil, product_count: nil, customer_id: nil } }

  describe "GET /orders" do
    it "returns a successful response" do
      get orders_path
      expect(response).to be_successful
    end
  end

  describe "GET /orders/new" do
    it "returns a successful response" do
      get new_order_path
      expect(response).to be_successful
    end
  end

  describe "POST /orders" do
    context "with valid parameters" do
      it "creates a new Order" do
        expect {
          post orders_path, params: { order: valid_attributes }
        }.to change(Order, :count).by(1)
      end

      it "redirects to the created order" do
        post orders_path, params: { order: valid_attributes }
        expect(response).to redirect_to(Order.last)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Order" do
        expect {
          post orders_path, params: { order: invalid_attributes }
        }.to change(Order, :count).by(0)
      end

      it "renders the 'new' template" do
        post orders_path, params: { order: invalid_attributes }
        expect(response).to render_template("new")
      end
    end
  end

  describe "GET /orders/:id" do
    let!(:order) { Order.create!(valid_attributes) }

    it "returns a successful response" do
      get order_path(order)
      expect(response).to be_successful
    end
  end

  describe "GET /orders/:id/edit" do
    let!(:order) { Order.create!(valid_attributes) }

    it "returns a successful response" do
      get edit_order_path(order)
      expect(response).to be_successful
    end
  end

  describe "PATCH /orders/:id" do
    let!(:order) { Order.create!(valid_attributes) }

    context "with valid parameters" do
      let(:new_attributes) { { product_name: "Updated Product", product_count: 10 } }

      it "updates the requested order" do
        patch order_path(order), params: { order: new_attributes }
        order.reload
        expect(order.product_name).to eq("Updated Product")
        expect(order.product_count).to eq(10)
      end

      it "redirects to the order" do
        patch order_path(order), params: { order: new_attributes }
        expect(response).to redirect_to(order)
      end
    end

    context "with invalid parameters" do
      it "does not update the order" do
        patch order_path(order), params: { order: invalid_attributes }
        order.reload
        expect(order.product_name).to eq("Sample Product") # Check that it hasn't changed
      end

      it "renders the 'edit' template" do
        patch order_path(order), params: { order: invalid_attributes }
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE /orders/:id" do
    let!(:order) { Order.create!(valid_attributes) }

    it "deletes the requested order" do
      expect {
        delete order_path(order)
      }.to change(Order, :count).by(-1)
    end

    it "redirects to the orders list" do
      delete order_path(order)
      expect(response).to redirect_to(orders_path)
    end
  end
end
