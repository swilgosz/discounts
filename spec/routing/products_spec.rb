require "rails_helper"

RSpec.describe ProductsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/").to route_to("products#index")
    end
    it "routes to #buy" do
      expect(patch: "/products/1/buy").to route_to("products#buy", id: '1')
    end
  end
end
