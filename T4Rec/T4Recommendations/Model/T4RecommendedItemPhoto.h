//
//  T4RecommendedItemPhoto.h
//  T4Rec
//
//  Created by Radhakrishnan Selvaraj on 26/07/15.
//  Copyright (c) 2015 Dev Krishnan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class T4Recommendation;

@interface T4RecommendedItemPhoto : NSManagedObject

@property (nonatomic, retain) NSString * entityID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) T4Recommendation *belongsToRecommendation;

@end
