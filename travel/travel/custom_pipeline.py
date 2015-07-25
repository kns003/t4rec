import urllib
import requests

from django.conf import settings

from django.template.defaultfilters import slugify
from urllib import urlopen
from travel.models import TravelUser


from django.http.response import HttpResponse, HttpResponseRedirect





def get_info_users(user_id, access_token):
    """
    Get extra information from social logins
    """
    print(user_id)
    url = 'https://graph.facebook.com/%s?access_token=%s' % (user_id, access_token)
    response = requests.get(url)
    travel_user = TravelUser(user_id = response['access_token'],
                            name = response.text['name'],
                            access_token = response['access_token'])
    travel_user.save()
    print ("user saved")