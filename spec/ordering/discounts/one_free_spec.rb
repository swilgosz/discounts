# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ordering::Discounts::OneFree do
  describe '#call' do
    let(:order) { create :order }
    let(:tea) { create :product, :green_tea }

    subject(:discount) { described_class.new }

    let(:item1) { create :line_item, order: order, product: tea, price: tea.price }
    let(:item2) { create :line_item, order: order, product: tea, price: tea.price }

    it 'does not change the first added tea' do
      item1
      subject.call(order.line_items)
      expect(item1.price).to eq(tea.price)
    end

    it 'changes the price of the second tea added' do
      item1
      item2
      subject.call(order.line_items)
      expect(item2.reload.price).to eq(0)
    end

    it 'restores the price of the free tea to original if the other one is removed' do
      item1
      item2
      subject.call(order.line_items)
      expect(item2.reload.price).to eq(0)

      item1.destroy.delete
      subject.call(order.reload.line_items)
      expect(item2.reload.price).to eq(tea.price)
    end
  end
end
