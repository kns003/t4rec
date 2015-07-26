//
//  T4Recommendation+Parsing.m
//  T4Rec
//
//  Created by Radhakrishnan Selvaraj on 25/07/15.
//  Copyright (c) 2015 Dev Krishnan. All rights reserved.
//

#import "T4Recommendation+Parsing.h"

#define imagesKey  @"images"
#define titleKey  @"title"
#define pidKey  @"pid"
#define detailKey  @"detail"
#define geo_locKey  @"geo_loc"
#define latKey  @"lat"
#define lngKey  @"lng"
#define distanceKey @"distance"
#define categoryKey @"category"



@implementation T4Recommendation (Parsing)

+ (void)importRecommendationDic:(NSDictionary*)contents intoContext:(NSManagedObjectContext*)context
{
  NSString* entityName = NSStringFromClass(self);
  T4Recommendation *recommendation = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:context];
  recommendation.name = [contents objectForKey:titleKey];
  recommendation.distance = [contents objectForKey:distanceKey];
  recommendation.category = [contents objectForKey:categoryKey];
  recommendation.entityID = [contents objectForKey:pidKey];
  recommendation.details = [contents objectForKey:detailKey];
 
  
}

-(void)updateRecommendationDic:(NSDictionary*)contents intoContext:(NSManagedObjectContext*)context
{
 
  self.name = [contents objectForKey:titleKey];
  self.distance = [contents objectForKey:distanceKey];
  self.category = [contents objectForKey:categoryKey];
  self.details = [contents objectForKey:detailKey];
}



+(NSString*)uniqueKeyInLocalModel
{
  return @"entityID";
}
+(NSString*)uniqueKeyInServerJSON
{
  return pidKey;
}






@end
