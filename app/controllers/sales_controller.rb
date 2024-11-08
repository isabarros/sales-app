class SalesController < ApplicationController
  def show
    sale = Sale.find(params[:id])

    render json: {
      id: sale.id,
      products: sale.items.includes([:product]).map do |item|
        {
          name: item.product.name,
          quantity: item.quantity
        }
      end
    }
  end
end
