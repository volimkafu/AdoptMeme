# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.transaction do 
  User.create(fname: 'Jennifer', lname: 'Hamon', zipcode: '32444', email: 'jhamon@gmail.com', username: 'jen' )
  User.create(fname: 'Jeff', lname: 'Fiddler', zipcode: '94303', email: 'jeff@gmail.com', username: 'jeff' )
  User.create(fname: 'Renata', lname: 'Cummins', zipcode: '94303', email: 'rcummins@gmail.com', username: 'renata' )
end

