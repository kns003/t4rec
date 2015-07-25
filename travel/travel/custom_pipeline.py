import urllib
import requests
import json
from django.conf import settings

from django.template.defaultfilters import slugify
from urllib import urlopen
from travel.models import TravelUser
from travel.Facebook_API_likes import likes_gather

from django.http.response import HttpResponse, HttpResponseRedirect





def get_info_users(user_id, access_token):
    """
    Get extra information from social logins
    """
    print(user_id)
    url = 'https://graph.facebook.com/%s?access_token=%s' % (user_id, access_token)
    response = requests.get(url)
    response_json = json.loads(response.text)
    print (response_json)
    travel_user = TravelUser(user_id = user_id,
                            name = response_json['name'],
                            access_token = access_token
                            )
    travel_user.save()
    print ("user saved")
    args = {'fields' : 'likes' ,}
    likes_gather('likes', args)
    #print json_likes['paging']['next']
    args = {'fields' : 'movies' ,}
    likes_gather('movies', args)
    args = {'fields' : 'music' ,}
    likes_gather('music', args)
    print likes
    likes_result = ''.join(likes)
    travel_user.likes_result = likes_result
    travel_user.save()
    