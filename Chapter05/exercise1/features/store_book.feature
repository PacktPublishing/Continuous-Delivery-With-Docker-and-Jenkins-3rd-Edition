Feature: Store book

Scenario: Store book in the library
  Given Book "The Lord of the Rings" by "J.R.R. Tolkien" with ISBN number "0395974682"
  When I store the book in library
  Then I am able to retrieve the book by the ISBN number