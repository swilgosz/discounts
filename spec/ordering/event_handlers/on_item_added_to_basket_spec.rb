# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ordering::Endpoints::BuyProduct do
  it 'creates a line item' do
    expect {
      endpoint.call(order: order.id, product: product.id)
    }.to change { LineItem.count }.by(1)
  end
end
