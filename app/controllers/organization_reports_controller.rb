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

    sales_reps = SalesRep.arel_table
    sales = Sale.arel_table
    products = Product.arel_table
    items = Item.arel_table
    top_products_query = products
                           .join(items).on(items[:product_id].eq(products[:id]))
                           .join(sales).on(sales[:id].eq(items[:sale_id]))
                           .join(sales_reps).on(sales_reps[:id].eq(sales[:sales_rep_id])
                                                               .and(sales_reps[:organization_id].eq(@organization.id)))
                           .project(products[:id], products[:name], items[:quantity].sum.as('total_quantity_sold'))
                           .group(products[:id])
                           .order('total_quantity_sold DESC')
                           .take(5)
                           .to_sql
    top_products_result = ActiveRecord::Base.connection.execute(top_products_query)

    # Format the top products for JSON response
    top_products_formatted = top_products_result.map do |product|
      {
        id: product['id'],
        name: product['name'],
        total_quantity_sold: product['total_quantity_sold'].to_i
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
