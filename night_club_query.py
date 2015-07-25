class NightClub:
	@staticmethod
	def GetPlaceQuery(hr, minute):
		NIGHT_CLUB_MIN = 20 * 60
		NIGHT_CLUB_MAX_MORN = 1 * 60

		time_curr = hr * 60 + minute

		if (time_curr >= NIGHT_CLUB_MIN or time_curr <= NIGHT_CLUB_MAX_MORN):
			return "night clubs near me"
		return "NONE"
