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
        return value != nil && ((NSString*)value).length ? (NSString*)value : @"";
    } else {
        return (value == nil || value == [NSNull null]) ? @"" : (NSString*)value;
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

////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////
@implementation PCCommonUtils

////////////////////////////////////////////////////////////////
+ (UIFont*) getTitleFont {
    UIFont *font = [UIFont systemFontOfSize:22];
    return font;
}
////////////////////////////////////////////////////////////////
+ (UIFont*) getHeaderFont {
    UIFont *font = [UIFont systemFontOfSize:18];
    return font;
}
////////////////////////////////////////////////////////////////
+ (UIFont*) getStandardFont {
    UIFont *font = [UIFont systemFontOfSize:14];
    return font;
}
////////////////////////////////////////////////////////////////
+ (UIFont*) getDescriptionFont {
    UIFont *font = [UIFont systemFontOfSize:10];
    return font;
}

@end