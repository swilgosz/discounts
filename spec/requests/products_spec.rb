require 'rails_helper'
require 'ordering/endpoints/buy_product'

RSpec.describe "/", type: :request do
  let!(:product) { Product.create(code: 'GT1', price: 3.00, name: 'Green Tea') }
  let!(:order) { Order.create(status: :open)}
  let!(:line_item) { LineItem.create(product: product, order: order, quantity: 1) }

  describe "GET /index" do
    it "renders a successful response" do
      get root_url
      expect(response).to be_successful
    end
  end

  describe "POST /buy" do
    context "with valid parameters" do
      it "creates a new LineItem" do
        expect_any_instance_of(Ordering::Endpoints::BuyProduct).to receive(:call).with(order: order.id, product: product.id.to_s).and_call_original
        expect {
          patch buy_product_url(product)
        }.to change(order.reload.line_items, :count).by(1)
      end
    end
  end
end
