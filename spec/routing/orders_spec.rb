require "rails_helper"

RSpec.describe OrdersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/orders").to route_to("orders#index")
    end

    it "routes to #close" do
      expect(patch: "/order/close").to route_to("orders#close")
    end
  end
end
