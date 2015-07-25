import facebook
import json
import urllib2

likes = []
token = 'CAACEdEose0cBAM0CzqZANY2J8yiwhIMNP9mslm5JUePrvJhqJiNLedmWHre7t71yCMfJVofZCmgi8Vlumg4YspNUzviLsnuFZCZBi2pUeY97zsRB68YFUqVCsTVktabf5AT3X7WZCairbg8prHyVu7GDIIBKjqrCiPqIA9ZCeny0brBeIAuaGZAPlDXqFm0rh3cEG1p3DzPdZAJDz9IqNp3v'
graph =  facebook.GraphAPI(access_token=token)#, version='2.4')
profile = graph.get_object("me")
likes.append(profile['quotes'].encode('utf8'))
def likes_gather(str, args):
    profile = graph.get_object('me', **args)
    #print profile
    for x in profile[str]['data']:
        likes.append(x['name'].encode('utf8'))
    try:
        json_likes = urllib2.urlopen(profile[str]['paging']['next']).read()
        json_likes = json.loads(json_likes)
        for x in json_likes['data']:
            likes.append(x['name'].encode('utf8'))
    except:
        pass
    #print json_likes['paging']['next']
    while(True):
        try:
            json_likes = urllib2.urlopen(json_likes['paging']['next']).read()
            json_likes = json.loads(json_likes)
            for x in json_likes['data']:
                likes.append(x['name'].encode('utf8'))
        except:
            #print json_likes
            break

args = {'fields' : 'likes' ,}
likes_gather('likes', args)
#print json_likes['paging']['next']
args = {'fields' : 'movies' ,}
likes_gather('movies', args)
args = {'fields' : 'music' ,}
likes_gather('music', args)
#args = {'fields' : 'favorite_teams' ,}
#likes_gather('favorite_teams', args)


print likes
print len(likes)
#print(profile['likes']['data'][0]['name'])
