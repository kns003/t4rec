import urllib
import requests

from django.conf import settings

from django.template.defaultfilters import slugify
from urllib import urlopen
from travel.models import TravelUser


from django.http.response import HttpResponse, HttpResponseRedirect





def get_info_users(backend, details, response, uid, user,is_new, *args, **kwargs):
    """
    Get extra information from social logins
    """

    if backend.name == 'facebook':
        print response
        travel_user = TravelUser(user_id = response['access_token'],
                                name = response['name'],
                                access_token = response['access_token'])
        travel_user.save()
        print ("user saved")