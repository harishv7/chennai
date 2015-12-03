require 'rubygems'
require 'oauth'
require 'json'
require 'date'

# Change the following values to those provided on dev.twitter.com
# The consumer key identifies the application making the request.
# The access token identifies the user making the request.
consumer_key = OAuth::Consumer.new(
    "ddsaQhGcGX9qMIBhkcFqrjbsB",
    "GklhbmtSY6KNGDYfXruFXqyKsJl3QWren3BHuVGKKrIpKAmDVm")
access_token = OAuth::Token.new(
    "167404741-VEwkeon0FVN7GKLNtgRUcfIqsxnbSOmvsAwy0Yzc",
    "wDBfNmN6SThJr6DsicRUWtkUuBWfsU2R3hyoaAU6QJ9sw")

# All requests will be sent to this server.
baseurl = "https://api.twitter.com"

def print_timeline(tweets)
  file = File.open('chennai.txt', 'w')
  tweets['statuses'].each do |tweet|
    puts tweet["text"]
    file.puts(tweet["text"] + "\n")
  end
end

# def print_timeline(tweets)
#   tweets.each do |tweet|
#     d = DateTime.new(tweet['created_at'])
#     puts "#{tweet['user']['name']} , #{tweet['text']} , #{d.strftime('%m.%d.%y')} , #{tweet['id']}"
#   end
# end

# The verify credentials endpoint returns a 200 status if
# the request is signed correctly.
#address = URI("#{baseurl}/1.1/account/verify_credentials.json")
address = URI("#{baseurl}/1.1/search/tweets.json?q=helpchennai&count=100")

# Set up Net::HTTP to use SSL, which is required by Twitter.
http = Net::HTTP.new address.host, address.port
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER

# Build the request and authorize it with OAuth.
request = Net::HTTP::Get.new address.request_uri
request.oauth! http, consumer_key, access_token

# Issue the request and return the response.
http.start
response = http.request request
puts "The response status was #{response.code}"

if response.code == '200' then
  tweets = JSON.parse(response.body)
  print_timeline(tweets)  
end
nil

