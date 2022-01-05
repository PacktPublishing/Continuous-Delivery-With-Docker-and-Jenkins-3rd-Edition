FROM ruby:3.1
RUN gem install rest-client sinatra json thin
COPY book-library.rb ./

EXPOSE 8080

CMD ["ruby", "book-library.rb", "-p", "8080"]