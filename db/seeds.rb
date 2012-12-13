# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user1 = User.create!(name: 'whichizrite', 
					username: 'whichizrite',
					email: 'info@whichizrite.com',
					password: 'foobar', 
					password_confirmation: 'foobar',
					sex: 'male',
					admin: true,
					location: 'Brooklyn, NY'
					)
user2 = User.create!(name: 'anonymous', 
					username: 'anonymous',
					email: 'anonymous@whichizrite.com',
					password: 'foobar', 
					password_confirmation: 'foobar',
					sex: 'male',
					location: 'Nonewhereland, Somewhere'
					)