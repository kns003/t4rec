//
//  T4ResponseHandlerController.m
//  T4Rec
//
//  Created by Radhakrishnan Selvaraj on 25/07/15.
//  Copyright (c) 2015 Dev Krishnan. All rights reserved.
//

#import "T4ResponseHandlerController.h"
#import "T4Rec-Swift.h"
#import "T4WebResponse.h"

@interface T4ResponseHandlerController ()
@property(nonatomic,copy) T4WebServiceCompletionBlock completionBlock;
@property(nonatomic)  T4WebAPIType requestType;
@property(nonatomic) T4WebResponse *webResponse;
@property(nonatomic) id<T4DownloadHandlerDelegate> responseDelegate;
@end

@implementation T4ResponseHandlerController
@synthesize requestType,responseDelegate;
#pragma mark Initialization
#pragma mark
-(id)initWithType:(T4WebAPIType)webRequestType withDelegate:(id<T4DownloadHandlerDelegate>) delegate
{
  self = [super init];
  if (self) {
    
    NSAssert1(webRequestType != None, @"Request Type can not be nil %s", __func__);
    if (webRequestType == None  ) {
      
      return nil;
    }
    requestType = webRequestType;
    responseDelegate =  delegate;
  }
  return self;
}
-(id)init
{
  return  [self initWithType:None withDelegate:nil];
}
#pragma mark Getter
#pragma mark
-(T4WebServiceCompletionBlock)completionBlock
{
  if (_completionBlock == nil){
    _completionBlock = [self completionBlockFromInitializer];
  }
  return _completionBlock;
}
#pragma mark InitializationOfCompletionBlock
#pragma mark
-(T4WebServiceCompletionBlock)completionBlockFromInitializer
{
  __weak __block T4ResponseHandlerController *blockSafeSelf = self;
  T4WebServiceCompletionBlock completionBlock = ^(NSData *data, NSURLResponse *response, NSError *error)
  {
    
    NSHTTPURLResponse *httpResponse =(NSHTTPURLResponse*) response;
    if(data.length > 0)
    {
      NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
      NSLog(@"string %@",string);
      

      NSArray *JSONList =
      [NSJSONSerialization JSONObjectWithData: [string dataUsingEncoding:NSUTF8StringEncoding]
                                      options: NSJSONReadingMutableContainers
                                        error: &error];
      
      if ([JSONList  isKindOfClass:[NSArray class]]) {
        
        T4WebResponse *webServiceResponse = [[T4WebResponse alloc]init];
    
        
        if (JSONList.count > 0 ) {
          
          
          //Message board or may be dictionary of response
          webServiceResponse.data = JSONList;
          webServiceResponse.responseType  = SuccessWithData;
          blockSafeSelf.webResponse = webServiceResponse;
          
        }
        else
        {
          webServiceResponse.data = nil;
          webServiceResponse.responseType  = SuccessWithNoData;
  
          blockSafeSelf.webResponse = webServiceResponse;
          
       
          
        }
        
      }
      else
      {
        
        blockSafeSelf.webResponse =[blockSafeSelf webResponseFromHttpResponse:httpResponse];
        
        
      }
      
      
      
    }
    else
    {
      T4WebResponse *serviceResponse = [[T4WebResponse alloc]init];
      
      serviceResponse.errorMessageTitle = @"Admin";
      serviceResponse.errorMessage = [error localizedDescription];
      serviceResponse.responseType = Failure;
      blockSafeSelf.webResponse = serviceResponse;
      
    }
    [blockSafeSelf.responseDelegate delegate:blockSafeSelf willfinishWithResponse:blockSafeSelf.webResponse];
    [blockSafeSelf.responseDelegate delegate:blockSafeSelf didfinishWithResponse:blockSafeSelf.webResponse];
  };
  return completionBlock;
}
#pragma mark Error-Handlers
#pragma mark

-(T4WebResponse*)webResponseFromHttpResponse:(NSHTTPURLResponse*)httpResponse
{
  T4WebResponse *serviceResponse = [[T4WebResponse alloc]init];
  
  if (httpResponse.statusCode == 200) {
    serviceResponse.responseType = SuccessWithNoData;
    serviceResponse.errorMessage = @"No data available from server";
  }
  else if (httpResponse.statusCode == 404)
  {
    serviceResponse.responseType = Failure;
    serviceResponse.errorMessage = @"Some Problem with Webservices. Please contact Admin";
  }
  else
  {
    serviceResponse.responseType = Failure;
    serviceResponse.errorMessage = [NSHTTPURLResponse localizedStringForStatusCode:httpResponse.statusCode];
  }
  return serviceResponse;
  
}


@end
