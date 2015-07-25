from django.shortcuts import render_to_response
from django.template.context import RequestContext
from django.http import HttpResponse
from travel.get_near_places import get_poi

def home(request):
   

   context = RequestContext(request,
                           {'request': request,
                            'user': request.user})

   return render_to_response('home.html',context_instance=context)

def get_suggestions(request):
	print("get_suggestions")
	lat = request.GET['lat']
	lon = request.GET['lon']
	hour = request.GET['hour']
	minute = request.GET['minute']
	print(hour,minute)
	traits = []
	response = get_poi(lat, lon, hour, minute, traits)
	print ("res" , 	response)
	return HttpResponse(response)

	
