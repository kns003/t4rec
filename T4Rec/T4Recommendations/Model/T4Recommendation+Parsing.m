//
//  T4Recommendation+Parsing.m
//  T4Rec
//
//  Created by Radhakrishnan Selvaraj on 25/07/15.
//  Copyright (c) 2015 Dev Krishnan. All rights reserved.
//

#import "T4Recommendation+Parsing.h"
#import "T4RecommendedItemPhoto.h"

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
 
  NSArray *imageURLS =  [contents objectForKey:imagesKey];
  NSString* photoEntityName = NSStringFromClass([T4RecommendedItemPhoto class]);
  for (NSString *url in imageURLS) {
    
    T4RecommendedItemPhoto *photo = [NSEntityDescription insertNewObjectForEntityForName:photoEntityName inManagedObjectContext:context];
    photo.url = url;
    photo.belongsToRecommendation = recommendation;
  }
  
}

-(void)updateRecommendationDic:(NSDictionary*)contents intoContext:(NSManagedObjectContext*)context
{
 
  self.name = [contents objectForKey:titleKey];
  self.distance = [contents objectForKey:distanceKey];
  self.category = [contents objectForKey:categoryKey];
  self.details = [contents objectForKey:detailKey];
  
 
  for (NSManagedObject *managedObject in self.hasPhotos) {
    [context deleteObject:managedObject];

  }

  NSArray *imageURLS =  [contents objectForKey:imagesKey];
  NSString* photoEntityName = NSStringFromClass([T4RecommendedItemPhoto class]);
  for (NSString *url in imageURLS) {
    
    T4RecommendedItemPhoto *photo = [NSEntityDescription insertNewObjectForEntityForName:photoEntityName inManagedObjectContext:context];
    photo.url = url;
    photo.belongsToRecommendation = self;
  }

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
