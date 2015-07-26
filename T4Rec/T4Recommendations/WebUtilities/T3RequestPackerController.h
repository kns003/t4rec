//
//  T3RequestPackerController.h
//  T4Rec
//
//  Created by Radhakrishnan Selvaraj on 25/07/15.
//  Copyright (c) 2015 Dev Krishnan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "T4Constants.h"
#import "T4APIRequestInfo.h"

@interface T3RequestPackerController : NSObject
-(id)initWithType:(T4WebAPIType)webRequestType withRequestInfo:(T4APIRequestInfo*)requestInfo;
-(NSURLRequest*)urlRequest;
@end
