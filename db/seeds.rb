# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Item.destroy_all
Category.destroy_all
Log.destroy_all

User.create(email: 'tom@tom.com', password: 'password')

Item.create(name: 'GT86', user_id: 1)

Item.create(name: 'House', user_id: 1)

Category.create(name: 'Oil Change', item_id: 1)
Category.create(name: 'Rotate Tires', item_id: 1)

Category.create(name: 'HVAC Filters', item_id: 2)
Category.create(name: 'Clean A/C Condenser', item_id: 2)

Log.create(date_performed: 400.days.ago, date_due: 100.days.ago, tools: 'wrench, rags, drip pan', cost: 40, notes: 'Used Castrol 0W-20', category_id: 1, item_id: 1)
Log.create(date_performed: 90.days.ago, date_due: Time.now, tools: 'wrench, rags, drip pan', cost: 40, notes: 'Used Motul 5W-30', category_id: 1, item_id: 1)
Log.create(date_performed:10.days.ago, date_due: 120.days.from_now, tools: 'lug wrench', cost: 0, notes: 'Due in 10k miles', category_id: 2, item_id: 1)

Log.create(date_performed: 120.days.ago, date_due: 20.days.from_now, tools: 'screwdriver', cost: 20, notes: 'Used 1200 Filter', category_id: 3, item_id: 2)
Log.create(date_performed: 300.days.ago, date_due: 10.days.ago, tools: 'hose', cost: 0, notes: 'Wash from inside out', category_id: 4, item_id: 2)
