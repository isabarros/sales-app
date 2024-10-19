class SalesController < ApplicationController
  def show
    # Find the sale by its ID
    sale = Sale.find(params[:id])

    # Format the data as JSON
    render json: {
      id: sale.id,
      products: sale.items.map do |item|
        {
          name: item.product.name,  # Get product name
          quantity: item.quantity   # Get item quantity
        }
      end
    }
  end
end
