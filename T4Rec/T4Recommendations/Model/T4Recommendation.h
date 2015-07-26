//
//  T4Recommendation.h
//  T4Rec
//
//  Created by Radhakrishnan Selvaraj on 26/07/15.
//  Copyright (c) 2015 Dev Krishnan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class T4RecommendedItemPhoto;

@interface T4Recommendation : NSManagedObject

@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * details;
@property (nonatomic, retain) NSString * distance;
@property (nonatomic, retain) NSString * entityID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *hasPhotos;
@end

@interface T4Recommendation (CoreDataGeneratedAccessors)

- (void)addHasPhotosObject:(T4RecommendedItemPhoto *)value;
- (void)removeHasPhotosObject:(T4RecommendedItemPhoto *)value;
- (void)addHasPhotos:(NSSet *)values;
- (void)removeHasPhotos:(NSSet *)values;

@end
