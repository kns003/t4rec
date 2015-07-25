from googleplaces import GooglePlaces, types, lang
from place import Place
from type_fetcher import TypeFetcher
import json

YOUR_API_KEY = 'AIzaSyCk8R2RvzH9AyeWYef4TCy0ag5nMEXvQBY'

google_places = GooglePlaces(YOUR_API_KEY)

# Gets points of interest for a given location.
def get_poi(lat, lon, hour, minute, traits):
	# Get type of locations you would want to have.
	print (lat)
	print lon
	query_types = TypeFetcher.fetch_type(hour, minute, traits)
	print(len(query_types))
	for query_type in query_types:
		places = get_nearby_result(query_type[0], lat, lon, [query_type[1]])
		print(places)
		if len(places) > 0:
			return json.dumps(places, default=Place.to_json)
		else:
			print "No results found"

def get_nearby_result(query, lat, lon, result_types):
	location_str = str(lat) + "," + str(lon)
	query_result = google_places.nearby_search(
		location=location_str, keyword=query,
		radius=20000, types=result_types)

	places = []
	length = min(query_result.places, 2)

	for g_place in query_result.places[:length]:
		place = Place(g_place.geo_location, g_place.name, g_place.place_id)
		g_place.get_details()
		place.set_detail(g_place.website)
		for photo in g_place.photos:
			photo.get(maxheight=500, maxwidth=500)
			place.add_image(photo.url)
		places.append(place)
	return places

get_poi(12.9667, 77.5667, 13, 0, [])
get_poi(12.9667, 77.5667, 0, 10, [])
