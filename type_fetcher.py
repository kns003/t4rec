import time
from googleplaces import types
from food_query import FoodQuery
from place_query import PlaceQuery

class TypeFetcher:
	@staticmethod
	def fetch_type(hour, minute, traits):
		queries = []
		food_query = FoodQuery.GetFoodQuery(hour, minute)
		if (food_query != "NONE"):
			queries.append((food_query, types.TYPE_FOOD))

		queries += PlaceQuery.GetPlaceQuery(hour, minute, traits)
		return queries

