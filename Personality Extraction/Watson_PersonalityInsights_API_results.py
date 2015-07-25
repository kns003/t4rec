import requests
import json

url="https://gateway.watsonplatform.net/personality-insights/api/v2/profile"
username="4dfe04df-437c-408c-9bf4-cb41568c8397"
password="OJKHgrXp77Y5"
with open ("test_result.txt", "r") as myfile:
    text=myfile.read()

raw_data = {
    'contentItems' : [{
        'contenttype' : 'text/plain',
        'content': text
    }]
}

input_data = json.dumps(raw_data)
response = requests.post(url, auth=(username, password), headers =   {'content-type': 'application/json'}, data=input_data)
with open('personality_json_py.txt','w') as f:
    f.write(response.text)

try:
    response.raise_for_status()
except requests.exceptions.HTTPError as e:
    print("And you get an HTTPError: %s"% e.message)
