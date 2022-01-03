require 'sinatra'

$books = {}

post '/books' do
  request.body.rewind
  new_book= request.body.read
  json = JSON.parse new_book
  $books[json["isbn"]] = new_book
  ""
end

get '/books/:isbn' do
  $books[params["isbn"]]
end