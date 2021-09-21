# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ordering::Discounts::CheaperStrawberries do
  describe '#call' do
    let(:order) { create :order }
    let(:strawberries) { create :product, :strawberries }

    subject(:discount) { described_class.new }

    let(:item1) { create :line_item, order: order, product: strawberries, price: strawberries.price }
    let(:item2) { create :line_item, order: order, product: strawberries, price: strawberries.price }
    let(:item3) { create :line_item, order: order, product: strawberries, price: strawberries.price }

    it 'does not change the first two strawberries' do
      item1
      item2
      subject.call(order.line_items)
      expect(item1.reload.price).to eq(strawberries.price)
      expect(item2.reload.price).to eq(strawberries.price)
    end

    it 'changes the price of all strawberries after third one' do
      item1
      item2
      item3
      subject.call(order.line_items)
      expect(item1.reload.price).to eq(Money.new(450))
      expect(item2.reload.price).to eq(Money.new(450))
      expect(item3.reload.price).to eq(Money.new(450))
    end

    it 'restores the price of the free strawberries to original if the other one is removed' do
      item1
      item2
      item3
      subject.call(order.line_items)
      item3.destroy
      subject.call(order.reload.line_items)
      expect(item1.reload.price).to eq(strawberries.price)
      expect(item2.reload.price).to eq(strawberries.price)
   end
  end
end
