# api_client/client.rb

# require 'faraday'

# response = Faraday.get 'http://localhost:3000/api/v1/products'
# p response.body


require 'faraday'
require 'json'

# We can use libraries to programmaticaly make http requests to any
# web site. There are many ruby libraries to do so. Here we're using
# the Faraday library. Do this when you interact with the web api
# of another application or your own internal applications
# (e.g. sending tweets with Twillio, managing your Github account,
#  tweeting with Twitter, etc.)

# The line below makes a get http request to our rails server
# products controller. We get the response object back.
response = Faraday.get 'http://localhost:3000/api/v1/products'
# Then, we use JSON.parse() to transform the large blob text
# into Ruby data structures.
p JSON.parse(response.body)
