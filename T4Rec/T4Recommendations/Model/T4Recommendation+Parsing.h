//
//  T4Recommendation+Parsing.h
//  T4Rec
//
//  Created by Radhakrishnan Selvaraj on 25/07/15.
//  Copyright (c) 2015 Dev Krishnan. All rights reserved.
//

#import "T4Recommendation.h"

@interface T4Recommendation (Parsing)
+(NSString*)uniqueKeyInServerJSON;
+(NSString*)uniqueKeyInLocalModel;
+ (void)importRecommendationDic:(NSDictionary*)contents intoContext:(NSManagedObjectContext*)context;
-(void)updateRecommendationDic:(NSDictionary*)contents intoContext:(NSManagedObjectContext*)context;
@end
