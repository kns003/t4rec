var fs = require("fs");
var data = fs.readFileSync('test_result.txt');
//console.log("Synchronous read: " + data.toString());
var watson = require('watson-developer-cloud');

var personality_insights = watson.personality_insights({
   username: '4dfe04df-437c-408c-9bf4-cb41568c8397',
   password: 'OJKHgrXp77Y5',
   version: 'v2'
 });


personality_insights.profile({
   text: data,
   language: 'en' },
   function (err, response) {
     if (err)
       console.log('error:', err);
     else
       console.log(JSON.stringify(response, null, 2));
 });
