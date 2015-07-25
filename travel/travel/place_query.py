from googleplaces import types
from person_traits import PersonTrait

class PlaceQuery:
	type_to_query = {
			"ART_GALLERY": ("art gallery near me", types.TYPE_ART_GALLERY),
			"BOWLING": ("gaming near me", types.TYPE_BOWLING_ALLEY),
			"GROCERY":("supermarkets near me", types.TYPE_GROCERY_OR_SUPERMARKET),
			"GOVT_OFF": ("government office near me", types.TYPE_LOCAL_GOVERNMENT_OFFICE),
			"HAIR":("salons near me", types.TYPE_HAIR_CARE),
			"HOTELS": ("hotels near me", types.TYPE_LODGING),
			"MALL":("places for shopping near me", types.TYPE_SHOPPING_MALL),
			"MUSEUM": ("museums near me", types.TYPE_MUSEUM),
			"MOVIE": ("movies near me", types.TYPE_MOVIE_THEATER),
			"NIGHT_CLUB":("movies near me", types.TYPE_NIGHT_CLUB),
			"PARK":("movies near me", types.TYPE_PARK),
			"SPA":("spa near me", types.TYPE_SPA),
			"WORSHIP":("places of worship near me", types.TYPE_PLACE_OF_WORSHIP)
			}
	@staticmethod
	def GetPlaceQuery(hr, minute, traits):
		queries = []
		for trait in traits :
			query_type = GetPlaceQueryForTrait(hr, minute, trait)
			if (len(query_type)>0):
				queries.append(query_type)
		return queries

	def GetPlaceQueryForTrait(hr, minute, trait):
		time_curr = hr * 60 + minute
		if (trait == PersonTrait.DOCUMENTARIAN):
			places = {
					"GOVT_OFF": (10, 13),
					"MUSEUM": (14, 16),
					"HOTELS": (19, 24)
				};
		if (trait == PersonTrait.CONNECTOR):
			places = {
					"MOVIE": (9, 12),
					"PARK": (14, 16),
					"NIGHT_CLUB": (18, 24)
				};
	
		if (trait == PersonTrait.CULTURE):
			places = {
					"WORSHIP": (9, 12),
					"SPA": (13, 16),
					"MALL": (16, 18),
					"GROCERY": (19, 24)
				};

		if (trait == PersonTrait.EXPLORER):
			places = {
					"BOWLING": (11, 12),
					"STADIUM": (14, 17),
					"TRAVEL_AGENCY": (18, 19),
					"HOTEL": (19, 24)
				};

		if (trait == PersonTrait.INDULGER):
			places = {
					"WORSHIP": (9, 12),
					"HAIR": (13, 16),
					"MALL": (16, 18),
					"LIQUOR": (19, 24)
				};

		for key, value in places.iteritems():
			if (PlaceQuery.IsPossible(value(0)*60, value(1) * 60, time_curr)):
			   return type_to_query[key]
		return ()
				

	def IsPossible(start, end, time):
		return time >= start and time <= end
