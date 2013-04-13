# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#create roles admin & normaluser
 ["admin", "normaluser"].each do |r|  
   Role.find_or_create_by_name r  
 end
 
#create admin user
 User.create(name: 'Admin', email: 'admin@yahoo.com', login: 'admin', password: 'admin', password_confirmation: 'admin', role_id: 1)

#create different question types for survey
 ["Essay Question", "Numeric Question", "Date Question"].each do |r|  
   Questiontype.find_or_create_by_name r  
 end