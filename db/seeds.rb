# Clear existing data (optional)
SalesRep.destroy_all
User.destroy_all

# Create Users with FFaker
10.times do
  User.create!(
    name: FFaker::Name.name,
    email: FFaker::Internet.email
  )
end

# Create SalesReps associated with some Users
User.all.sample(5).each do |user|
  SalesRep.create!(
    user: user,
  )
end

# Output counts
puts "#{User.count} users created."
puts "#{SalesRep.count} sales reps created."
