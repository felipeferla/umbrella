require "http"
require "json"



pp "What is your location?"
location = gets
#puts location

google_maps_api_key = ENV.fetch("GMAPS_KEY")

google_maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + location + "&key=" + google_maps_api_key 

raw_response = HTTP.get(google_maps_url)
parsed_response = JSON.parse(raw_response)
latitude = parsed_response["results"][0]["geometry"]["location"]["lat"]

pp latitude

longitude = parsed_response["results"][0]["geometry"]["location"]["lng"]
pp longitude

pirate_weather_api_key = ENV.fetch("API_KEY_APPDEV")

pirate_weather_api_url = "https://api.pirateweather.net/forecast/" + pirate_weather_api_key + "/" + latitude.to_s + "," + longitude.to_s

pp pirate_weather_api_url
raw_response_weather = HTTP.get (pirate_weather_api_url)
parsed_response_weather = JSON.parse(raw_response_weather)

currently = parsed_response_weather.fetch("currently") 
summary = currently.fetch("summary")
likelihood_raining = currently.fetch("precipProbability") * 100
temp = currently.fetch("temperature")

pp summary
pp "Currently the temperature is " + temp.to_s + " degrees and the likelihood of raining is " + likelihood_raining.to_s + "%"
