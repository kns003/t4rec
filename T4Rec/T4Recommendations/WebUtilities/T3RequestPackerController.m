//
//  T3RequestPackerController.m
//  T4Rec
//
//  Created by Radhakrishnan Selvaraj on 25/07/15.
//  Copyright (c) 2015 Dev Krishnan. All rights reserved.
//

#import "T3RequestPackerController.h"
#import "T4Constants.h"

@interface T3RequestPackerController ()
@property(nonatomic)T4WebAPIType requestType;
@property(nonatomic,strong)T4APIRequestInfo *requestInfo;
@end

@implementation T3RequestPackerController
@synthesize requestType,requestInfo;
-(id)initWithType:(T4WebAPIType)webRequestType withRequestInfo:(T4APIRequestInfo*)info
{
  self = [super init];
  if (self) {
    
    NSAssert1(webRequestType != None && info != nil, @"Request Type can not be nil and Type can not be None %s", __func__);
    if (webRequestType == None || info == nil ) {
   
      return nil;
    }
    requestType = webRequestType;
    requestInfo = info;
    
  }
  return self;
}

-(id)init
{
  return  [self initWithType:None withRequestInfo:nil];
  
}


-(NSURLRequest*)urlRequest
{
  
  
  NSURLRequest *urlRequest = nil;
  
  switch (requestType) {
      
    case Recommendations:
    {
      urlRequest = [self urlRequestForRecommendations];
    }
      break;

      
      
    default:
      abort();
      NSAssert1(NO, @"A Valid webservice type should be chosen %s", __func__);
      break;
  }
  return urlRequest;
}

-(NSURLRequest*)urlRequestForRecommendations
{
  //http://t4rec.com:8000/get_suggestions/?lat=12.9667&lon=77.5667&hour=13&minute=0
  NSString *baseURL = [[NSUserDefaults standardUserDefaults] objectForKey:kBaseIPURL];;
  NSString *urlString = [NSString stringWithFormat:@"%@/get_suggestions/?lat=%@&lon=%@&hour=%@&minute=%@&user_id=%@&access_token=%@",baseURL,self.requestInfo.latitude,self.requestInfo.longitude,self.requestInfo.hour,self.requestInfo.minute,self.requestInfo.userID,self.requestInfo.accessToken];
  NSURLRequest *request = [self urlRequestForURLString:urlString withHTTPFieldValues:nil withBody:nil];
  return request;
}


-(NSURLRequest*)urlRequestForURLString:(NSString*)urlString withHTTPFieldValues:(NSDictionary*)dictionary withBody:(NSData*)bodyData
{
  
  NSURL *url = [NSURL URLWithString:urlString];
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];



  //[request setAllHTTPHeaderFields:headers];
  
  
  
  [request setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
  
  //[request setValue:[NSString stringWithFormat:@"application/json; charset=%@", charset] forHTTPHeaderField:@"Content-Type"];
  if (bodyData) {
    [request setHTTPBody:bodyData];
  }
  
  
  if (dictionary) {
    
    for (NSString *httpHeader in [dictionary allKeys]) {
      
      NSString *httpHeaderValue = [dictionary  objectForKey:httpHeader];
      
      [request setValue:httpHeaderValue forHTTPHeaderField:httpHeader];
    }
  }
  return request;
  
}
@end
