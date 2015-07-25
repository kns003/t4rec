import json

class Place:
	def __init__(self, geo_loc, title, pid):
		self.geo_loc = geo_loc
		self.title = title
		self.pid = pid
		self.detail = ''
		self.images = []
	def set_detail(self, detail):
		self.detail = detail

	def add_image(self, image_url):
		self.images.append(image_url)

	@staticmethod
	def to_json(obj):
		return json.dumps(obj.__dict__)
