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
        self.factTitle = safe([[factDict objectForKey:NSLocalizedString(@"factTitleKey", nil)] retain]);
        self.factDescription = safe([[factDict objectForKey:NSLocalizedString(@"factDescriptionKey", nil)] retain]);
        self.factImageUrl = safe([[factDict objectForKey:NSLocalizedString(@"factImageUrlKey", nil)] retain]);
    }
    return self;
}

///////////////////////////////////////////////////////////////
-(BOOL) isEmpty {
    return ( [self.factTitle isEqualToString:@""] &&
             [self.factDescription isEqualToString:@""] &&
            [self.factImageUrl isEqualToString:@""]);
}

///////////////////////////////////////////////////////////////
-(void)dealloc {
    NSLog(@"%@", self.factTitle);
    NSLog(@"%@", self.factDescription);
    NSLog(@"%@", self.factImageUrl);
    NSLog(@"======================================");
    [self.factTitle release];
    self.factTitle = nil;
    [self.factTitle dealloc];
    [self.factImageUrl release];
    self.factImageUrl = nil;
    [self.factImageUrl dealloc];
    [self.factDescription release];
    self.factDescription = nil;
    [self.factDescription dealloc];
    [super dealloc];
}

@end
