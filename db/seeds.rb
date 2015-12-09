# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

user = User.create :email => 'mary@example.com', :password => 'guessit'
user = User.create :email => 'thienle.tma@gmail.com', :password => '123456'
user = User.create :email => 'user@gmail.com', :password => '123456'

Category.create [{:name => 'Programming'}, 
  {:name => 'Event'}, 
  {:name => 'Travel'}, 
  {:name => 'Music'}, 
  {:name => 'TV'}]