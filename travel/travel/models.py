from django.db import models
from django.conf import settings

class TravelUser(models.Model):
	user_id = models.CharField(max_length = 50, blank=True, null=True)
	name = models.CharField(max_length = 100, blank=True, null=True)
	access_token = models.CharField(max_length=2000,blank=True, null=True)
	likes_result = models. CharField(max_length=9999,blank=True,null=True)
	