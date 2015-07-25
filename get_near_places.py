from googleplaces import GooglePlaces, types, lang
from place import Place
from type_fetcher import TypeFetcher
import json

YOUR_API_KEY = 'AIzaSyCk8R2RvzH9AyeWYef4TCy0ag5nMEXvQBY'

google_places = GooglePlaces(YOUR_API_KEY)

# Gets points of interest for a given location.
def get_poi(lat, lon, hour, minute):
	# Get type of locations you would want to have.
	query_type = TypeFetcher.fetch_type(hour, minute)
	if (len(query_type)) > 0:
		print query_type[1]
		places = get_nearby_result(query_type[0], lat, lon, [query_type[1]])
		if len(places) > 0:
			print json.dumps(places, default=Place.to_json)
		else:
			print "No results found"
	else:
		print "No possible query"

def get_nearby_result(query, lat, lon, result_types):
	location_str = str(lat) + "," + str(lon)
	print "Query : " + query
	query_result = google_places.nearby_search(
		location=location_str, keyword=query,
		radius=20000, types=result_types)

	places = []
	for g_place in query_result.places:
		place = Place(g_place.geo_location, g_place.name, g_place.place_id)
		places.append(place)
	return places
		# Returned places from a query are place summaries.
		#print place.name
		#print place.geo_location
		#print place.place_id
		# The following method has to make a further API call.
		#place.get_details()
		# Referencing any of the attributes below, prior to making a call to
		# get_details() will raise a googleplaces.GooglePlacesAttributeError.
		#print place.details # A dict matching the JSON response from Google.
		#print place.local_phone_number
		#print place.international_phone_number
		#print place.website
		#print place.url

	    	#for photo in g_place.photos:
			# 'maxheight' or 'maxwidth' is required
		#	photo.get(maxheight=500, maxwidth=500)
			# MIME-type, e.g. 'image/jpeg'
		#	photo.mimetype
			# Image URL
		#	photo.url
			# Original filename (optional)
		#	photo.filename
			# Raw image data
		#	photo.data
get_poi(12.9667, 77.5667, 13, 0)
get_poi(12.9667, 77.5667, 0, 10)
