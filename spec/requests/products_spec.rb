require 'rails_helper'

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
end
