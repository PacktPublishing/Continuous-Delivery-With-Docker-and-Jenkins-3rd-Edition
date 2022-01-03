FROM ruby:2.5
RUN gem install sinatra
COPY book-library.rb ./

EXPOSE 8080

CMD ["ruby", "book-library.rb", "-p", "8080"]