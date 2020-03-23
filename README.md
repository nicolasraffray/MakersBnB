# Makers Bnb

## How to Run 

  - Fork or Clone this repo 
  - cd into the toplevel directory of this project
  - run "bundle install" in the commandline
  - run rackup -p 9292
  - In your browser visit localhost:9292 

# MakersBnB specification

We would like a web application that allows users to list spaces they have available, and to hire spaces for the night.

## User Stories

As a user,
So that I can see places to rent
I’d like to be able to browse properties

As a user,
So I can use all the website’s functionalities
I’d like to be able to sign up

As a registered user,
So I can rent my places,
I’d like to add listings

As a registered user,
So I can change information about my places,
I’d like to update my listings

As a registered user,
So I can enjoy a holiday,
I’d like to book a place

As a registered user,
So I can select my guests,
I’d like to be able to confirm or deny a booking

As a registered user,
So I don’t end up with double bookings,
I’d like to show the listing’s availability

As a registered user,
So I don’t reduce my renting chances
I’d like to show the listings available till confirmation


### Headline specifications

- Any signed-up user can list a new space.
- Users can list multiple spaces.
- Users should be able to name their space, provide a short description of the space, and a price per night.
- Users should be able to offer a range of dates where their space is available.
- Any signed-up user can request to hire any space for one night, and this should be approved by the user that owns that space.
- Nights for which a space has already been booked should not be available for users to book that space.
- Until a user has confirmed a booking request, that space can still be booked for that night.

### Nice-to-haves

- Users should receive an email whenever one of the following happens:
 - They sign up
 - They create a space
 - They update a space
 - A user requests to book their space
 - They confirm a request
 - They request to book a space
 - Their request to book a space is confirmed
 - Their request to book a space is denied
- Users should receive a text message to a provided number whenever one of the following happens:
 - A user requests to book their space
 - Their request to book a space is confirmed
 - Their request to book a space is denied
- A ‘chat’ functionality once a space has been booked, allowing users whose space-booking request has been confirmed to chat with the user that owns that space
- Basic payment implementation though Stripe.



![Tracking pixel](https://githubanalytics.herokuapp.com/course/makersbnb/specification_and_mockups.md)
