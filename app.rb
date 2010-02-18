require 'rubygems'
require 'sinatra'
require 'haml'
require 'active_record'

get '/' do
  redirect '/people'
end

get '/people' do
  haml :people, :locals => { :people => some_people(25) }
end

get '/time' do
  haml :time, :locals => { :current_time => Time.now, :intervals => date_intervals(10) }
end

get '/stylesheets/styles.css' do
  header 'Content-Type' => 'text/css; charset=utf-8'
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
  quantity.times do |number|
    number += 1
    age = (15..30).to_a.choice
    person = { :name => "Person_#{number}", :age => age, :children => [{ :name => "Children_#{number}" }]}
    people << person
  end
  people
end