//
//  PCCountryFact.h
//  PacteraTest
//
//  Created by Prashant Gami on 22/01/2015.
//  Copyright (c) 2015 Pectera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCCountryFact : NSObject

@property (nonatomic, strong) NSString *factTitle;
@property (nonatomic, strong) NSString *factDescription;
@property (nonatomic, strong) NSString *factImageUrl;

-(instancetype) initWithDictionary:(NSDictionary*)factDict;

@end
