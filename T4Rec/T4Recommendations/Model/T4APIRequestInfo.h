//
//  T4APIRequestInfo.h
//  T4Rec
//
//  Created by Radhakrishnan Selvaraj on 25/07/15.
//  Copyright (c) 2015 Dev Krishnan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface T4APIRequestInfo : NSObject
@property(nonatomic,strong)NSString *latitude;
@property(nonatomic,strong)NSString *longitude;
@property(nonatomic,strong)NSString *hour;
@property(nonatomic,strong)NSString *minute;
@property(nonatomic,strong)NSString *userID;
@property(nonatomic,strong)NSString *accessToken;
@end
