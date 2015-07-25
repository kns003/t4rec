//
//  ViewController.m
//  T4Recommendations
//
//  Created by Radhakrishnan Selvaraj on 25/07/15.
//  Copyright (c) 2015 Dev Krishnan. All rights reserved.
//

#import "T4RecommendationListViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <CoreLocation/CoreLocation.h>
#import "T4RecommendationListViewController.h"
#import "T4RecommendationInfoCell.h"
#import "MTCardLayout.h"
#import "UICollectionView+CardLayout.h"
#import "LSCollectionViewLayoutHelper.h"
#import "UICollectionView+Draggable.h"
#import "T4DataImportOperation.h"
#import "T4DownloadOperation.h"
#import "T4Recommendation.h"
#import "T4RecommendedItemPhoto.h"
#import "T4Rec-Swift.h"
#import "T4WebResponse.h"
#import "UIView+RNActivityView.h"


@interface T4RecommendationListViewController ()< UICollectionViewDataSource_Draggable,T4DownloadOperationDelegate,T4DataImportStatusDelegate>

@property(nonatomic,strong)NSOperationQueue *operationQueue;
@property (nonatomic, strong) NSMutableArray * items;
@property(nonatomic,strong)T4DataImportOperation *importOperation;
@property(nonatomic,strong)T4DownloadOperation *downLoadOperation;
@property(nonatomic,strong)T4DataStore *dataStore;

@end

@implementation T4RecommendationListViewController
@synthesize importOperation,downLoadOperation,dataStore;

#pragma mark Status Bar color

- (UIStatusBarStyle)preferredStatusBarStyle
{
  return UIStatusBarStyleLightContent;
}

#pragma mark - View Lifecycle

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  [self.collectionView setPresenting:YES animated:YES completion:nil];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.operationQueue = [[NSOperationQueue alloc]init];
  self.dataStore = [[T4DataStore alloc]init];
  [self reloadRecommendations];
  self.items = [NSMutableArray arrayWithCapacity:20];
  for (int i = 0; i < 20; i++)
  {
    [self.items addObject:[NSString stringWithFormat:@"Item %d", i]];
  }
  
  UIImageView *dropOnToDeleteView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"trashcan"] highlightedImage:[UIImage imageNamed:@"trashcan_red"]];
  dropOnToDeleteView.center = CGPointMake(50, 300);
  self.collectionView.dropOnToDeleteView = dropOnToDeleteView;
  
  UIImageView *dragUpToDeleteConfirmView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"trashcan"] highlightedImage:[UIImage imageNamed:@"trashcan_red"]];
  self.collectionView.dragUpToDeleteConfirmView = dragUpToDeleteConfirmView;
}

#pragma mark - UICollectionViewDatasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  T4RecommendationInfoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"pass" forIndexPath:indexPath];
  
  cell.titleLabel.text = self.items[indexPath.item];
  return cell;
}

- (UIImage *)collectionView:(UICollectionView *)collectionView imageForDraggingItemAtIndexPath:(NSIndexPath *)indexPath
{
  UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
  CGSize size = cell.bounds.size;
  size.height = 72.0;
  
  UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
  CGContextRef context = UIGraphicsGetCurrentContext();
  [cell.layer renderInContext:context];
  
  UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return image;
}

- (CGAffineTransform)collectionView:(UICollectionView *)collectionView transformForDraggingItemAtIndexPath:(NSIndexPath *)indexPath duration:(NSTimeInterval *)duration
{
  return CGAffineTransformMakeScale(1.05f, 1.05f);
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
  return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
  NSString * item = self.items[fromIndexPath.item];
  [self.items removeObjectAtIndex:fromIndexPath.item];
  [self.items insertObject:item atIndex:toIndexPath.item];
}

- (void)collectionView:(UICollectionView *)collectionView didMoveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}

- (BOOL)collectionView:(UICollectionView *)collectionView canDeleteItemAtIndexPath:(NSIndexPath *)indexPath
{
  return YES;
}

- (void)collectionView:(UICollectionView *)collectionView deleteItemAtIndexPath:(NSIndexPath *)indexPath
{
  [self.items removeObjectAtIndex:indexPath.item];
}

- (void)collectionView:(UICollectionView *)collectionView didDeleteItemAtIndexPath:(NSIndexPath *)indexPath
{
}


#pragma mark Backside

- (IBAction)flip:(id)sender
{
  T4RecommendationInfoCell *cell = (T4RecommendationInfoCell *)[self.collectionView cellForItemAtIndexPath:[[self.collectionView indexPathsForSelectedItems] firstObject]];
  if (sender == cell.infoButton)
  {
    [cell flipTransitionWithOptions:UIViewAnimationOptionTransitionFlipFromLeft halfway:^(BOOL finished) {
      cell.infoButton.hidden = YES;
      cell.doneButton.hidden = NO;
    } completion:nil];
  }
  else
  {
    [cell flipTransitionWithOptions:UIViewAnimationOptionTransitionFlipFromRight halfway:^(BOOL finished) {
      cell.infoButton.hidden = NO;
      cell.doneButton.hidden = YES;
    } completion:nil];
  }
}


#pragma mark Reload
#pragma mark
-(IBAction)reloadRecommendations
{
  //t4rec.com:8000/get_suggestions/?lat=12.9667&lon=77.5667&hour=13&minute=0
  [self.operationQueue cancelAllOperations];
  
  FBSDKAccessToken *accessToken =[FBSDKAccessToken currentAccessToken];

  
  T4APIRequestInfo *requestInfo = [[T4APIRequestInfo alloc]init];
  requestInfo.latitude= @"12.9667";
  requestInfo.longitude= @"77.5667";
  NSDate *today = [NSDate date];
  NSCalendar *gregorian = [[NSCalendar alloc]
                           initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
  NSDateComponents *hourMin =
  [gregorian components:(NSCalendarUnitMinute | NSCalendarUnitHour) fromDate:today];
  requestInfo.hour= [[NSString alloc]initWithFormat:@"%ld",(long)hourMin.hour]; ;
  requestInfo.minute= [[NSString alloc]initWithFormat:@"%ld",(long)hourMin.minute]; ;
  requestInfo.userID= accessToken.userID;
  requestInfo.accessToken = accessToken.tokenString;
  self.downLoadOperation = [[T4DownloadOperation alloc]initWithMode:Recommendations withDelegate:self withRequestInfo:requestInfo ];
  [self.operationQueue addOperation:downLoadOperation];
  [self.view showActivityViewWithLabel:@"Loading"];
  
}

#pragma mark DownLoadDelegate
#pragma mark
- (void)downloadOperationWillComplete:(T4DownloadOperation * __nonnull)operation type:(T4WebAPIType)type
{
  
  T4WebResponse *response = operation.webResponse;
  if (response.responseType == SuccessWithData)
  {
    self.importOperation = [[T4DataImportOperation alloc]initWithStore:self.dataStore withData:response.data withType:type withDelegate:self];
    
  }
  else if(response.responseType == SuccessWithNoData)
  {
    
  }
  else
  {
    
  }
  [self.view hideActivityView];

}
- (void)downloadOperationCompleted:(T4DownloadOperation * __nonnull)operation type:(T4WebAPIType)type
{
  T4WebResponse *response = operation.webResponse;
  if (response.responseType == SuccessWithData)
  {
    [self.operationQueue addOperation:importOperation];
  }
  [self.view hideActivityView];
}
- (void)downloadOperationCancelled:(NSOperation * __nonnull)operation type:(T4WebAPIType)type
{
  [self.view hideActivityView];
}

#pragma mark
#pragma mark

- (void)importOperationCompleted:(T4DataImportOperation * __nonnull)operation importOperationType:(T4WebAPIType)importOperationType
{
  
  [self.collectionView reloadData];
}
- (void)importOperationCancelled:(T4DataImportOperation * __nonnull)operation importOperationType:(T4WebAPIType)importOperationType
{
  
}
- (void)importOperationFailed:(T4DataImportOperation * __nonnull)operation importOperationType:(T4WebAPIType)importOperationType withError:(NSError * __nonnull)withError
{
  
}

@end
