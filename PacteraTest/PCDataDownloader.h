//
//  PCDataDownloader.h
//  PacteraTest
//
//  Created by Prashant Gami on 22/01/2015.
//  Copyright (c) 2015 Pectera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCDataDownloader : NSObject

+(void) loadCountryDatFromServer:(void (^)(NSString* listTitle, NSArray* factArray))success
                         failure:(void (^)(NSError* error))failure;

@end
