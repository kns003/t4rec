//
//  T4DataImportOperation.h
//  T4Rec
//
//  Created by Radhakrishnan Selvaraj on 25/07/15.
//  Copyright (c) 2015 Dev Krishnan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "T4Constants.h"

@protocol T4DataImportStatusDelegate;
@class T4DataStore;

@interface T4DataImportOperation : NSOperation
- (id)initWithStore:(T4DataStore*)store withData:(NSArray*)dataList withType:(T4WebAPIType)apiType withDelegate:(id<T4DataImportStatusDelegate> )delegate;
@property (nonatomic) float progress;
@property (nonatomic, copy) void (^progressCallback) (float);
@end
