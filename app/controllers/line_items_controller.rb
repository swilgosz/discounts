class LineItemsController < ApplicationController
  def destroy
    endpoint = Ordering::Endpoints::RemoveItem.new(event_store: Rails.configuration.event_store)
    endpoint.call(params[:id])
    respond_to do |format|
      format.html { redirect_to root_url, notice: "Line item was successfully destroyed." }
    end
  end
end
