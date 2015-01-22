//
//  PCCommonUtils.m
//  PacteraTest
//
//  Created by Prashant Gami on 22/01/2015.
//  Copyright (c) 2015 Pectera. All rights reserved.
//

#import "PCCommonUtils.h"

////////////////////////////////////////////////////////////////
NSString* safe (NSObject* value) {
    if ([value isKindOfClass:[NSString class]]) {
        return value != nil && ((NSString*)value).length ? value : @"";
    } else {
        return (value == nil || value == [NSNull null]) ? @"" : value;
    }
}

////////////////////////////////////////////////////////////////
NSString* safeString (NSString* value) {
    return (NSString*) safe(value);
}

NSArray* safeArray (NSArray* value) {
    if ([value isKindOfClass:[NSArray class]]) {
        return value;
    } else {
        return nil;
    }
}

@implementation PCCommonUtils

+ (UIFont*) getTitleFont { return [UIFont systemFontOfSize:22]; }
+ (UIFont*) getHeaderFont { return [UIFont systemFontOfSize:18]; }
+ (UIFont*) getStandardFont { return [UIFont systemFontOfSize:14]; }
+ (UIFont*) getDescriptionFont { return [UIFont systemFontOfSize:10]; }



@end