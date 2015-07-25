import time
from googleplaces import types

class TypeFetcher:
	@staticmethod
	def fetch_type(hour, minute):
		food_query = TypeFetcher.GetFoodQuery(hour, minute)
		if (food_query != "NONE"):
			return (food_query, types.TYPE_FOOD)

		place_query = TypeFetcher.GetPlaceQuery(hour, minute)
		if (place_query != "NONE"):
			return (place_query , types.TYPE_NIGHT_CLUB)
		else:
			return ()

	@staticmethod
	def GetFoodQuery(hr, minute):
		BFAST_MIN_MINUTE = 60 * 7
		BFAST_MAX_MINUTE = 60 * 10

		LUNCH_MIN_MINUTE = 60 * 12
		LUNCH_MAX_MINUTE = 60 * 14

		SNACK_MIN_MINUTE = 60 * 16
		SNACK_MAX_MINUTE = 60 * 18

		DINNER_MIN_MINUTE = 60 * 20
		DINNER_MAX_MINUTE = 60 * 22

		time_curr = hr * 60 + minute

		if (time_curr >= BFAST_MIN_MINUTE and time_curr <= BFAST_MAX_MINUTE):
			return "coffee shop near me"
		if (time_curr >= LUNCH_MIN_MINUTE and time_curr <= LUNCH_MAX_MINUTE):
			return "restaurant near me"
		if (time_curr >= SNACK_MIN_MINUTE and time_curr <= SNACK_MAX_MINUTE):
			return "coffee shop near me"
		if (time_curr >= DINNER_MIN_MINUTE and time_curr <= DINNER_MAX_MINUTE):
			return "restaurant near me"
		return "NONE"

	@staticmethod
	def GetPlaceQuery(hr, minute):
		NIGHT_CLUB_MIN = 20 * 60
		NIGHT_CLUB_MAX_MORN = 1 * 60

		time_curr = hr * 60 + minute

		if (time_curr >= NIGHT_CLUB_MIN or time_curr <= NIGHT_CLUB_MAX_MORN):
			return "night clubs near me"
		return "NONE"
