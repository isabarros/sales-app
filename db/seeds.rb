# db/seeds.rb

# Clear existing data (optional)
Item.destroy_all
Sale.destroy_all
SalesRep.destroy_all
User.destroy_all
Product.destroy_all

# Create Products with FFaker
products = []
10.times do
  products << Product.create!(
    name: FFaker::Product.product_name,
    price: FFaker::Random.rand(10..100)  # Random price between 10 and 100
  )
end

# Create Users with FFaker
users = []
10.times do
  users << User.create!(
    name: FFaker::Name.name,
    email: FFaker::Internet.email
  )
end

# Create SalesReps associated with some Users
users.sample(5).each do |user|
  SalesRep.create!(user: user)
end

# Create Sales and Items associated with SalesReps and Products
SalesRep.all.each do |sales_rep|
  sale = Sale.create!(sales_rep: sales_rep) # No total attribute needed

  # Create 1-5 random Items for each Sale
  rand(1..5).times do
    product = products.sample # Randomly select a product
    quantity = FFaker::Random.rand(1..5) # Random quantity between 1 and 5

    # Create the item for this sale
    Item.create!(
      sale: sale,
      product: product,
      quantity: quantity
    )
  end
end

# Output counts for verification
puts "#{User.count} users created."
puts "#{SalesRep.count} sales reps created."
puts "#{Product.count} products created."
puts "#{Sale.count} sales created."
puts "#{Item.count} items created."
