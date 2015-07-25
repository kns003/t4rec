//
//  T4ResponseHandlerController.h
//  T4Rec
//
//  Created by Radhakrishnan Selvaraj on 25/07/15.
//  Copyright (c) 2015 Dev Krishnan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "T4Constants.h"

@class T4WebResponse;
@class T4ResponseHandlerController;
@protocol T4DownloadHandlerDelegate <NSObject>


-(void)delegate:(T4ResponseHandlerController*)delegate didfinishWithResponse:(T4WebResponse*)response;
-(void)delegate:(T4ResponseHandlerController*)delegate willfinishWithResponse:(T4WebResponse*)response;

@end


@interface T4ResponseHandlerController : NSObject
-(id)initWithType:(T4WebAPIType)webRequestType withDelegate:(id<T4DownloadHandlerDelegate>) delegate;
@property(nonatomic,copy,readonly) T4WebServiceCompletionBlock completionBlock;
@end
