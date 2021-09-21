# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ordering::Endpoints::BuyProduct do
  let(:event_store) { Rails.configuration.event_store }
  let(:order) { Order.create(status: :open) }
  let(:product) { create :product }

  let(:endpoint) { described_class.new(event_store: event_store) }

  describe '#call' do
    it 'publishes the event' do
      endpoint.call(order: order.id, product: product.id)
      expect(event_store).to have_published(
        an_event(Ordering::Events::ItemAddedToBasket)
      ).in_stream("Order$#{order.id}")
    end
  end
end
