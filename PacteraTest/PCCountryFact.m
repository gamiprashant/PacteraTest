//
//  PCCountryFact.m
//  PacteraTest
//
//  Created by Prashant Gami on 22/01/2015.
//  Copyright (c) 2015 Pectera. All rights reserved.
//

#import "PCCountryFact.h"
#import "PCCommonUtils.h"

///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
@implementation PCCountryFact

///////////////////////////////////////////////////////////////
-(instancetype) initWithDictionary:(NSDictionary *)factDict {
    self = [super init];
    if(self) {
        self.factTitle = safe([factDict objectForKey:NSLocalizedString(@"factTitleKey", nil)]);
        self.factDescription = safe([factDict objectForKey:NSLocalizedString(@"factDescriptionKey", nil)]);
        self.factImageUrl = safe([factDict objectForKey:NSLocalizedString(@"factImageUrlKey", nil)]);
        
    }
    return self;
}

///////////////////////////////////////////////////////////////
-(BOOL) isEmpty {
    return ( [self.factTitle isEqualToString:@""] &&
             [self.factDescription isEqualToString:@""] &&
            [self.factImageUrl isEqualToString:@""]);
}
@end
