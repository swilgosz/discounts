require "rails_helper"

RSpec.describe LineItemsController, type: :routing do
  describe "routing" do
    it "routes to #destroy" do
      expect(delete: "/line_items/1").to route_to("line_items#destroy", id: "1")
    end
  end
end
