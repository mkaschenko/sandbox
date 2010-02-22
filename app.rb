require 'rubygems'
require 'sinatra'
require 'haml'
require 'Sass'
require 'active_record'

get '/' do
  redirect '/people'
end

get '/people' do
  haml :people, :locals => { :people => some_people(5) }
end

get '/time' do
  haml :time, :locals => { :current_time => Time.now, :intervals => date_intervals(10) }
end

get '/stylesheets/styles.css' do
  headers 'Content-Type' => 'text/css; charset=utf-8'
  sass :styles
end

private

def date_intervals(quantity = 1)
  intervals = []
  date = Date.today
  quantity.times{ |number| intervals << date + 10*(number+1) }
  intervals
end

def some_people(quantity = 1)
  people = []
  ages = (20..40).to_a
  children_ages = (5..10).to_a
  quantity.times do |number|
    number += 1
    person = { :name => "Person_#{number}", :age => ages.choice, 
               :children => [{ :name => "Child_#{number}", :age => children_ages.choice }] }
    people << person
  end
  people
end