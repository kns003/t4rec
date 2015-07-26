//
//  T4DownloadOperation.h
//  T4Rec
//
//  Created by Radhakrishnan Selvaraj on 25/07/15.
//  Copyright (c) 2015 Dev Krishnan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "T4Constants.h"
#import "T4APIRequestInfo.h"
@class T4WebResponse;
@protocol T4DownloadOperationDelegate;
@interface T4DownloadOperation : NSOperation<NSURLSessionDataDelegate>
- (id)initWithMode:(T4WebAPIType)theMode withDelegate:(id<T4DownloadOperationDelegate>)delegate withRequestInfo:(T4APIRequestInfo*)requestInfo;
@property(nonatomic,strong)T4WebResponse *webResponse;
@end
