import urllib
import requests

from django.conf import settings

from django.template.defaultfilters import slugify
from urllib import urlopen

from django.contrib.auth import get_user_model
from django.http.response import HttpResponse, HttpResponseRedirect
User = get_user_model()




def get_info_users(backend, details, response, uid, user,is_new, *args, **kwargs):
    """
    Get extra information from social logins
    """
    print (response)
    print(backend.name)
    if backend.name == 'facebook':
        print response