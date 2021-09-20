require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '.statuses' do
    it 'supprots proper statuses' do
      expect(Order.statuses).to eq('open' => 1, 'closed' => 2)
    end

    it 'sets proper status' do
      order = Order.create(status: :open)
      expect(order.status).to eq('open')
    end
  end
end
