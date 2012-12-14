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

user3 = User.create!(name: 'tester1', 
					username: 'tester1',
					email: 'tester1@whichizrite.com',
					password: 'foobar', 
					password_confirmation: 'foobar',
					sex: 'female',
					location: 'Nonewhereland, Somewhere'
					)

user4 = User.create!(name: 'tester2', 
					username: 'tester2',
					email: 'tester2@whichizrite.com',
					password: 'foobar', 
					password_confirmation: 'foobar',
					sex: 'male',
					private_user: true,
					location: 'Nonewhereland, Somewhere'
					)