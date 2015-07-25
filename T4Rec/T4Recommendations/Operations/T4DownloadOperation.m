//
//  T4DownloadOperation.m
//  T4Rec
//
//  Created by Radhakrishnan Selvaraj on 25/07/15.
//  Copyright (c) 2015 Dev Krishnan. All rights reserved.
//

#import "T4DownloadOperation.h"
#import "T4Rec-Swift.h"
#import "T4Constants.h"
#import "T4ResponseHandlerController.h"
#import "T3RequestPackerController.h"

@interface T4DownloadOperation()<T4DownloadHandlerDelegate>
{
  BOOL        executing;
  BOOL        finished;
}
@property(nonatomic,strong)NSURLRequest *webRequest;
@property(nonatomic,strong)NSURLSession *defaultSession;
@property(nonatomic)  T4WebAPIType requestType;
@property(nonatomic,weak)id<T4DownloadOperationDelegate> completionDelegate;
@property(nonatomic,strong)T4ResponseHandlerController *responseDelegate;
@property(nonatomic,strong)T4APIRequestInfo *requestInfo;
@end

@implementation T4DownloadOperation

@synthesize defaultSession,webRequest,requestType;
@synthesize completionDelegate,responseDelegate,requestInfo;
- (id)initWithMode:(T4WebAPIType)theMode withDelegate:(id<T4DownloadOperationDelegate>)delegate withRequestInfo:(T4APIRequestInfo*)apiInfo
{
  self = [super init];
  if (self) {
    
    
    NSAssert1(apiInfo != nil, @"requestInfo can not be nil %s", __func__);
    if (apiInfo == nil) {
      return nil;
    }
    executing = NO;
    finished = NO;
    
    requestType = theMode;
    requestInfo = apiInfo;
    completionDelegate = delegate;
  }
  return self;
}


- (void)start {
  
  // Ensure this operation is not being restarted and that it has not been cancelled
  //if( [self finished] || [self isCancelled] ) { [self done]; return; }
  if ([self isCancelled]) {
    [self cancelOperation];
    return;
  }
  
  
  T3RequestPackerController *packerDelegate = [[T3RequestPackerController alloc]initWithType:requestType withRequestInfo:requestInfo];
  
  self.responseDelegate = [[T4ResponseHandlerController alloc]initWithType:requestType withDelegate:self];
  NSAssert1(responseDelegate.completionBlock, @"Completion block can not be nil", __func__);
  [self invokeWebServiceWithRequest:packerDelegate.urlRequest CompletionHandler:responseDelegate.completionBlock];
  executing = YES;
  
  [self didChangeValueForKey:@"isExecuting"];
  if ([self isCancelled]) {
    [self cancelOperation];
    return;
  }
  
  
  
}
-(void)cancelOperation
{
  [self requestFinished];
  [self.completionDelegate downloadOperationCancelled:self type:self.requestType];
  
}

//It indicates the Request is done
-(void)requestFinished{
  
  [defaultSession invalidateAndCancel];
  
  [self willChangeValueForKey:@"isFinished"];
  
  [self willChangeValueForKey:@"isExecuting"];
  
  executing = NO;
  finished = YES;
  
  [self didChangeValueForKey:@"isExecuting"];
  [self didChangeValueForKey:@"isFinished"];
  
  
}

#pragma mark WebService-Invocation
#pragma mark

-(void)invokeWebServiceWithRequest:(NSURLRequest*)request CompletionHandler:(T4WebServiceCompletionBlock)completionHandler{
  
  if ([self isCancelled]) {
    [self cancelOperation];
    return;
  }
  
  NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
  self.defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
  
  
  NSURLSessionDataTask *task = [defaultSession dataTaskWithRequest:request
                                                 completionHandler:completionHandler];
  
  
  [task resume];
#ifdef LOGTIMEOFSERVER
  ALog(@"Request began %@",[NSDate date])
#endif
  
  if ([self isCancelled]) {
    [self cancelOperation];
    return;
  }
}


#pragma mark URLSession-Methods
#pragma mark


#pragma mark Response-From-Server
#pragma mark
-(void)delegate:(T4ResponseHandlerController*)delegate didfinishWithResponse:(T4WebResponse*)response
{
  self.webResponse = response;
  [self requestFinished];
  DLog(@"self Deelgate %@",self.completionDelegate)
  [self.completionDelegate downloadOperationCompleted:self type:self.requestType];
}

-(void)delegate:(T4ResponseHandlerController*)delegate willfinishWithResponse:(T4WebResponse*)response
{
  self.webResponse = response;
  DLog(@"self Deelgate %@",self.completionDelegate)
  [self.completionDelegate downloadOperationWillComplete:self type:self.requestType];
}


@end
