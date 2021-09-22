# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ordering::Endpoints::CloseOrder do
  let(:event_store) { Rails.configuration.event_store }
  let(:order) { Order.create(status: :open) }
  let(:product) { create :product }

  let(:endpoint) { described_class.new(event_store: event_store) }

  describe '#call' do
    it 'publishes the event' do
      expect { endpoint.call }.to change { order.reload.status }.from('open').to('closed')
      expect(event_store).to have_published(
        an_event(Ordering::Events::OrderClosed)
      ).in_stream("Order$#{order.id}")
    end
  end
end
