//
//  T4Constants.h
//  T4Rec
//
//  Created by Radhakrishnan Selvaraj on 25/07/15.
//  Copyright (c) 2015 Dev Krishnan. All rights reserved.
//

#ifndef T4Rec_T4Constants_h
#define T4Rec_T4Constants_h

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif
// ALog will always output like NSLog

#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define kBackgroundColor 0xF8F9FA
#define kNavBarColor 0x333078
#define kOddCellBGColor 0x9DA1D1
#define kEvenCellBGColor 0xCECFD8

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, T4WebAPIType) {
  None,
  Recommendations,
  Login,
  PhotoFetch
};

typedef NS_ENUM(NSUInteger, T4WebResponseType) {
  SuccessWithData,
  SuccessWithNoData,
  Failure
};


static NSString * AFBase64EncodedStringFromString(NSString *string) {
  NSData *data = [NSData dataWithBytes:[string UTF8String] length:[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
  NSUInteger length = [data length];
  NSMutableData *mutableData = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
  
  uint8_t *input = (uint8_t *)[data bytes];
  uint8_t *output = (uint8_t *)[mutableData mutableBytes];
  
  for (NSUInteger i = 0; i < length; i += 3) {
    NSUInteger value = 0;
    for (NSUInteger j = i; j < (i + 3); j++) {
      value <<= 8;
      if (j < length) {
        value |= (0xFF & input[j]);
      }
    }
    
    static uint8_t const kAFBase64EncodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    
    NSUInteger idx = (i / 3) * 4;
    output[idx + 0] = kAFBase64EncodingTable[(value >> 18) & 0x3F];
    output[idx + 1] = kAFBase64EncodingTable[(value >> 12) & 0x3F];
    output[idx + 2] = (i + 1) < length ? kAFBase64EncodingTable[(value >> 6)  & 0x3F] : '=';
    output[idx + 3] = (i + 2) < length ? kAFBase64EncodingTable[(value >> 0)  & 0x3F] : '=';
  }
  
  return [[NSString alloc] initWithData:mutableData encoding:NSASCIIStringEncoding];
}

typedef    void (^T4WebServiceCompletionBlock)(NSData *data, NSURLResponse *response, NSError *error);

#pragma mark Keys-In-User-Defaults
#pragma mark
#define kBaseIPURL @"BaseURLKey"
//#define

#endif
