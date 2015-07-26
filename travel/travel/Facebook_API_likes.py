import facebook
import json
import urllib2


# token = 'CAACEdEose0cBABlMPvluxIx9JIxKTafsnwZACr4VjFwgsR6kQGiHbrsZAsy7Ve59X95Ik6B5HK8gIGGFXtYBr6IZCswyPHVnneb9snQs1JsbrZAN5ZAhte3zSSZBbcrHMuYYR7wNvXMiqte72IbN5SK7HFuZBMVJusyfMZAv7QrccLZBZBauBmpBVJewWPplaQPtJ52aibRWeWfAZANidnypxSZB'
# graph =  facebook.GraphAPI(access_token=token)#, version='2.4')
# profile = graph.get_object("me")

def likes_gather(str, args, token, likes=[]):
    graph =  facebook.GraphAPI(access_token=token)
    profile = graph.get_object('me', **args)
    # print profile
    
    # likes.append(profile['quotes'].encode('utf8'))
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
                return likes
        except:
            #print json_likes
            break
