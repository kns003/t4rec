import urllib
import requests
import json
from django.conf import settings
import os
from django.template.defaultfilters import slugify
from urllib import urlopen
from travel.models import TravelUser
from travel.Facebook_API_likes import likes_gather
from travel.Personality_Type import personality_type
from django.http.response import HttpResponse, HttpResponseRedirect
import subprocess

url="https://gateway.watsonplatform.net/personality-insights/api/v2/profile"
username="4dfe04df-437c-408c-9bf4-cb41568c8397"
password="OJKHgrXp77Y5"



def get_info_users(user_id, access_token):
    """
    Get extra information from social logins
    """
    print(user_id)
    url = 'https://graph.facebook.com/%s?access_token=%s' % (user_id, access_token)
    response = requests.get(url)
    response_json = json.loads(response.text)
    print ("response_json", response_json)
    travel_user = TravelUser.objects.create(user_id = user_id,
                            name = response_json['name'],
                            access_token = access_token
                            )
    travel_user.save()
    print ("user saved")
    likes_list = []
    args = {'fields' : 'likes'}
    like_likes = likes_gather(args['fields'], args, access_token,likes_list)
    args = {'fields' : 'movies' ,}
    movie = likes_gather('movies', args, like_likes)
    args = {'fields' : 'music' ,}
    music = likes_gather('music', args, movie)
    print music
    likes_result = ', '.join(like_likes)
    print likes_result
    travel_user.likes_result = likes_result
    travel_user.save()
    traits = get_watson_status(likes_result, travel_user)
    print traits
    return traits
    

def get_watson_status(likes_result, travel_user):
    raw_data = {
    'contentItems' : [{
        'contenttype' : 'text/plain',
        'content': likes_result
        }]
    }

    input_data = json.dumps(raw_data)
    response = requests.post(url, auth=(username, password), headers =   
    {'content-type': 'application/json'}, data=input_data)
    travel_user.watson_data = response.text
    print(travel_user.watson_data)
    travel_user.save()
    traits = personality_type(response.text)
    return traits
    







