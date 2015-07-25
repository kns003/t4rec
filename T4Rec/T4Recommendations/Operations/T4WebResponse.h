//
//  T4WebResponse.h
//  T4Rec
//
//  Created by Radhakrishnan Selaj on 25/07/15.
//  Copyright (c) 2015 Dev Krishnan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "T4Constants.h"

@interface T4WebResponse : NSObject
@property(nonatomic,strong)NSArray  *data;
@property(nonatomic,strong)NSString  *errorMessage;
@property(nonatomic,strong)NSString  *errorMessageTitle;
@property(nonatomic,strong)NSString  *errorCode;
@property(nonatomic)T4WebResponseType  responseType;

@end
