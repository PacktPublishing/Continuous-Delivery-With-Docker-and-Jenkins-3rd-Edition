require 'rest-client'
require 'json'

Given /^Book "(.*)" by "(.*)" with ISBN number "(.*)"$/ do |name, author, isbn|
	@name = name
	@author = author
	@isbn = isbn
end

When /^I store the book in library$/ do
	url = "http://localhost:8080/books"
	payload = {name: @name, author: @author, isbn: @isbn}.to_json
	headers = {content_type: :json}
	RestClient.post(url, payload, headers)
end

Then /^I am able to retrieve the book by the ISBN number$/ do
	url = "http://localhost:8080/books/#{@isbn}"
	result = JSON.parse RestClient.get(url)
	fail if @name != result['name']
	fail if @author != result['author']
	fail if @isbn != result['isbn']
end