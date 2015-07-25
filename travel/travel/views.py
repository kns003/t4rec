from django.shortcuts import render_to_response
from django.template.context import RequestContext
from django.http import HttpResponse
from travel.get_near_places import get_poi
from travel.custom_pipeline import get_info_users

def home(request):
   

   context = RequestContext(request,
                           {'request': request,
                            'user': request.user})

   return render_to_response('home.html',context_instance=context)

def get_suggestions(request):
	print("get_suggestions")
	access_token = request.COOKIES.get('access_token')
	lat = float(request.GET['lat'])
	lon = float(request.GET['lon'])
	hour = int(request.GET['hour'])
	minute = int(request.GET['minute'])
	user_id = request.GET['user_id']
	get_info_users(user_id, access_token)
	traits = []
	response = get_poi(lat, lon, hour, minute, traits)
	return HttpResponse(response)

	
