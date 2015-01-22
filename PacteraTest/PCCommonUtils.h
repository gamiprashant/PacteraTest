//
//  PCCommonUtils.h
//  PacteraTest
//
//  Created by Prashant Gami on 22/01/2015.
//  Copyright (c) 2015 Pectera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NSString* safe (NSObject* value);
NSString* safeString (NSString* value);
NSArray* safeArray (NSArray* value);

@interface PCCommonUtils : NSObject

+ (UIFont*) getTitleFont;
+ (UIFont*) getHeaderFont;
+ (UIFont*) getStandardFont;
+ (UIFont*) getDescriptionFont;

@end
