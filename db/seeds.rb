# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

categories = ['ELECTRONICS', 'FURNITURE', 'HOME APPLIANCES', 'SPORTING GOODS', 'OUTDOOR', 'TOYS']
# create category for products
categories.each do |category|
  Category.find_or_create_by!(title: category)
end

# create user
User.find_or_create_by!(email: 'teebay_user@sazim.io') do |user|
  user.first_name = 'Teebay',
  user.last_name = 'User',
  user.phone = '01857123456',
  user.password = '123456',
  user.password_confirmation = '123456',
  user.address = 'Banani, Dhaka'
end

user = User.find_by(email: 'teebay_user@sazim.io')
# create products
prod_cricket_kit = Product.find_or_create_by!( title: 'Cricket Kit',
                                               description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna
                                                              aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                                               purchase_price: 500,
                                               rent_price: 100,
                                               rent_charge_type: :daily,
                                               created_by_id: user.id
                                             )
prod_cricket_kit.product_categories.find_or_create_by!({category_id: Category.find_or_create_by!(title: 'SPORTING GOODS').id})
prod_cricket_kit.product_categories.find_or_create_by!({category_id: Category.find_or_create_by!(title: 'OUTDOOR').id})

prod_phone = Product.find_or_create_by!( title: 'iPhone 13 pro max',
                                         description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna
                                          aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                                         purchase_price: 1500,
                                         rent_price: 50,
                                         rent_charge_type: :hourly,
                                         created_by_id: user.id
                                       )

prod_phone.product_categories.find_or_create_by!(category_id: Category.find_or_create_by!(title: 'ELECTRONICS').id)

# seed for rented product
UserProduct.find_or_create_by!(user_id: user.id,
                               product_id: prod_phone.id,
                               exchange_type: 1,
                               from_date: '2023-03-15',
                               to_date: '2023-03-16')
# seed for brought product
UserProduct.find_or_create_by!(user_id: user.id,
                               product_id: prod_cricket_kit.id)
