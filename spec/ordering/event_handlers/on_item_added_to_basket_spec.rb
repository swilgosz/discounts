# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ordering::EventHandlers::OnItemAddedToBasket do
  let(:order) { Order.create(status: :open) }
  let(:strawberies) { create :product, :strawberries }

  subject(:handler) { described_class.new }

  let(:event) do
    Ordering::Events::ItemAddedToBasket.new(data: {
      order_id: order.id, product_code: strawberies.code, quantity: 1
    })
  end

  it 'creates a line item' do
    expect { handler.call(event) }.to change { LineItem.count }.by(1)
  end

  it "calculates total order cost" do
    expect { handler.call(event) }.to change { order.reload.total }.from(Money.new(0)).to(Money.new(500))
    expect { handler.call(event) }.to change { order.reload.total }.from(Money.new(500)).to(Money.new(1000))
  end
end
