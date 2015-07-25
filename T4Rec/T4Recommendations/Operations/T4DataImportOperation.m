//
//  T4DataImportOperation.m
//  T4Rec
//
//  Created by Radhakrishnan Selvaraj on 25/07/15.
//  Copyright (c) 2015 Dev Krishnan. All rights reserved.
//

#import "T4DataImportOperation.h"
#import "T4Rec-Swift.h"
#import <CoreData/CoreData.h>
#import "T4Recommendation.h"
#import "T4Recommendation+Parsing.h"
#import "T4RecommendedItemPhoto.h"
#import "T4RecommendedItemPhoto+Parsing.h"

static const int ImportBatchSize = 10;

@interface T4DataImportOperation ()
@property (nonatomic, copy) NSArray* jsonList;
@property (nonatomic, strong) T4DataStore* store;
@property (nonatomic, strong) NSManagedObjectContext* context;
@property (nonatomic) T4WebAPIType requestType;
@property (nonatomic,weak)id<T4DataImportStatusDelegate> statusDelegate;
@end

@implementation T4DataImportOperation
@synthesize requestType,jsonList,statusDelegate;
- (id)initWithStore:(T4DataStore*)store withData:(NSArray*)dataList withType:(T4WebAPIType)apiType withDelegate:(id<T4DataImportStatusDelegate> )delegate
{
  self = [super init];
  if(self) {
    self.store = store;
    self.jsonList = dataList;
    requestType = apiType;
    statusDelegate = delegate;
  }
  return self;
}


- (void)main
{

  self.context = [self.store importingManagedObjectContext];
  self.context.undoManager = nil;
  if (requestType == Recommendations) {
    [self.context performBlockAndWait:^
     {
       [self import];
     }];
  }
  
}

- (void)import
{


  NSInteger count = jsonList.count;
  NSInteger progressGranularity = count/100;
  BOOL isAscending = YES;
  NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:[T4Recommendation uniqueKeyInServerJSON]  ascending:isAscending];
  self.jsonList = [self.jsonList sortedArrayUsingDescriptors:@[descriptor]];
  NSArray *listOfItems = [self.jsonList valueForKey:[T4Recommendation uniqueKeyInServerJSON]];
  
  // Create the fetch request to get all Employees matching the IDs.
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
  [fetchRequest setEntity:
   [NSEntityDescription entityForName:NSStringFromClass([T4Recommendation class]) inManagedObjectContext:self.context]];
  [fetchRequest setPredicate: [NSPredicate predicateWithFormat:@"(%K IN %@)",[T4Recommendation uniqueKeyInLocalModel], listOfItems]];
  
  // make sure the results are sorted as well
  [fetchRequest setSortDescriptors:
   @[[[NSSortDescriptor alloc] initWithKey: [T4Recommendation uniqueKeyInLocalModel] ascending:isAscending]]];
  NSError *error;
  NSArray *recommendationsMatchingIDs = [self.context executeFetchRequest:fetchRequest error:&error];

  
  __weak T4DataImportOperation *weakSelf = self;
  [recommendationsMatchingIDs enumerateObjectsUsingBlock:^(T4Recommendation *itemToUpdate, NSUInteger idx, BOOL *shouldStop) {
  
    if(self.isCancelled) {
      *shouldStop = YES;
       [statusDelegate importOperationCancelled:self importOperationType:requestType];
      return;
    }
    NSDictionary *dictionaryDetails = [weakSelf.jsonList objectAtIndex:idx];
    [itemToUpdate updateRecommendationDic:dictionaryDetails intoContext:self.context];
    
    if (idx % progressGranularity == 0) {
      self.progressCallback(idx / (float) count);
    }
    if (idx % ImportBatchSize == 0) {
      [self.context save:NULL];
    }
  }];

  self.progressCallback(1);
  [self.context save:NULL];
  [statusDelegate importOperationCompleted:self importOperationType:requestType];
}
@end
