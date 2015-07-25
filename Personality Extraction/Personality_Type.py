import json
import operator

with open('personality_json.txt') as f:
    watson_data = f.read()

watson_data = json.loads(watson_data)
#Documentarian
#3. 1.Artistic Interests
#print watson_data['tree']['children'][0]['children'][0]['children'][0]['children'][1]['id']
art_int = watson_data['tree']['children'][0]['children'][0]['children'][0]['children'][1]['percentage']

#4. 2.Emotionality
#print watson_data['tree']['children'][0]['children'][0]['children'][0]['children'][2]['id']
#print watson_data['tree']['children'][0]['children'][0]['children'][0]['children'][2]['percentage']
emo_int = watson_data['tree']['children'][0]['children'][0]['children'][0]['children'][2]['percentage']

#5. 3.Imagination
#print watson_data['tree']['children'][0]['children'][0]['children'][0]['children'][3]['id']
#print watson_data['tree']['children'][0]['children'][0]['children'][0]['children'][3]['percentage']
imag_int = watson_data['tree']['children'][0]['children'][0]['children'][0]['children'][3]['percentage']

Documentarian = imag_int + emo_int + art_int
#print ("Documentarian: " + str(Documentarian))
#Connector

#1. 1.Openness percentage
#print watson_data['tree']['children'][0]['children'][0]['children'][0]['id']
#print watson_data['tree']['children'][0]['children'][0]['children'][0]['percentage']
Openness_int = watson_data['tree']['children'][0]['children'][0]['children'][0]['percentage']

#6. 2.Cheerfulness
#print watson_data['tree']['children'][0]['children'][0]['children'][2]['children'][2]['id']
#print watson_data['tree']['children'][0]['children'][0]['children'][2]['children'][2]['percentage']
cheer_int = watson_data['tree']['children'][0]['children'][0]['children'][2]['children'][2]['percentage']

#9. 3.Self-expression
#print watson_data['tree']['children'][1]['children'][0]['children'][9]['id']
#print watson_data['tree']['children'][1]['children'][0]['children'][9]['percentage']
self_exp_int = watson_data['tree']['children'][1]['children'][0]['children'][9]['percentage']

Connector = self_exp_int + cheer_int + Openness_int
#print ('Connector: ' + str(Connector))
#Culture Venture

#12. 1.Openness to change
#print watson_data['tree']['children'][2]['children'][0]['children'][1]['id']
#print watson_data['tree']['children'][2]['children'][0]['children'][1]['percentage']
open_change_int = watson_data['tree']['children'][2]['children'][0]['children'][1]['percentage']

#11. 2.Curiosity
#print watson_data['tree']['children'][1]['children'][0]['children'][2]['id']
#print watson_data['tree']['children'][1]['children'][0]['children'][2]['percentage']
curious_int = watson_data['tree']['children'][1]['children'][0]['children'][2]['percentage']

#10. 3.Liberty
#print watson_data['tree']['children'][1]['children'][0]['children'][6]['id']
#print watson_data['tree']['children'][1]['children'][0]['children'][6]['percentage']
liberty_int = watson_data['tree']['children'][1]['children'][0]['children'][6]['percentage']

Culture_Venture = liberty_int + curious_int + open_change_int
#print("Culture Venture: " + str(Culture_Venture))


#Active Explorer

#2. 1.Adventurousness percentage
#print watson_data['tree']['children'][0]['children'][0]['children'][0]['children'][0]['id']
#print watson_data['tree']['children'][0]['children'][0]['children'][0]['children'][0]['percentage']
advent_int = watson_data['tree']['children'][0]['children'][0]['children'][0]['children'][0]['percentage']

#7. 2.Achievement striving
#print watson_data['tree']['children'][0]['children'][0]['children'][1]['children'][0]['id']
#print watson_data['tree']['children'][0]['children'][0]['children'][1]['children'][0]['percentage']
achieve_int = watson_data['tree']['children'][0]['children'][0]['children'][1]['children'][0]['percentage']

#8. 3.Challenge
#print watson_data['tree']['children'][1]['children'][0]['children'][0]['id']
#print watson_data['tree']['children'][1]['children'][0]['children'][0]['percentage']
challenge_int = watson_data['tree']['children'][1]['children'][0]['children'][0]['percentage']

Explorer_int = challenge_int + achieve_int + advent_int
#print ("The Active Explorer: " + str(Explorer_int))
#The indulger

#10. 1.Liberty
#print watson_data['tree']['children'][1]['children'][0]['children'][6]['id']
#print watson_data['tree']['children'][1]['children'][0]['children'][6]['percentage']


#13. 2.Hedonism
#print watson_data['tree']['children'][2]['children'][0]['children'][2]['id']
#print watson_data['tree']['children'][2]['children'][0]['children'][2]['percentage']
hedo_int = watson_data['tree']['children'][2]['children'][0]['children'][2]['percentage']
#14. 3.Self-transcandance
#print watson_data['tree']['children'][2]['children'][0]['children'][4]['id']
#print watson_data['tree']['children'][2]['children'][0]['children'][4]['percentage']
self_trans_int = watson_data['tree']['children'][2]['children'][0]['children'][4]['percentage']

indulger = liberty_int + hedo_int + self_trans_int
#print("The Indulger: " + str(indulger))

personality_dict = {}
personality_dict = {
   'Documentarian': Documentarian,
   'Connector': Connector,
   'Culture Venture': Culture_Venture,
   'The Active Explorer': Explorer_int,
   'The Indulger': indulger
}

sorted_personality_dict = sorted(personality_dict.items(), key=operator.itemgetter(1), reverse=True)
for x in sorted_personality_dict:
    print x[0]
#with open('personality.txt', 'w') as f:
#   f.write(sorted_personality_dict.join(','))
