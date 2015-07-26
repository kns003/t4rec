//
//  A3Utility.m
//  T4Rec
//
//  Created by Radhakrishnan Selvaraj on 26/07/15.
//  Copyright (c) 2015 Dev Krishnan. All rights reserved.
//

#import "T4Utility.h"
#import <UIKit/UIKit.h>

@implementation T4Utility
+ (void) displayAlertView:(NSString *)message withDelay:(CGFloat)delayInSeconds
{
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)( delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    [T4Utility displayAlertView:message];
  });
}

#pragma mark Display alertMessage
//Displays the Alert Message
+ (void) displayAlertView:(NSString *)message
{
  
  UIAlertView *alertMessage = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Recommendations",@"") message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
  [alertMessage show];
  
  return;
  
}

@end
