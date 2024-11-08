class OrganizationReportsController < ApplicationController
  def show
    @organization = Organization.find(params[:id])

    total_sales_reps = @organization.sales_reps.count
    total_sales = Sale.joins(:sales_rep).where(sales_reps: { organization_id: @organization.id }).count
    total_revenue = Sale.joins(sales_rep: :organization)
                        .joins(items: :product)
                        .where(sales_reps: { organization_id: @organization.id })
                        .sum('products.price * items.quantity')
                        .to_f
    top_products = Product.joins(items: { sale: :sales_rep })
                          .where(sales_reps: { organization_id: @organization.id })
                          .select('products.id, products.name, SUM(items.quantity) AS total_quantity_sold')
                          .group('products.id')
                          .order('total_quantity_sold DESC')
                          .limit(5)

    top_products_formatted = top_products.map do |product|
      {
        id: product.id,
        name: product.name,
        total_quantity_sold: product.total_quantity_sold.to_i
      }
    end

    render json: {
      total_sales_reps:,
      total_sales:,
      total_revenue:,
      top_products: top_products_formatted
    }
  end
end
