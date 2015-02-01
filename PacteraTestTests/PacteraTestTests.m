//
//  PacteraTestTests.m
//  PacteraTestTests
//
//  Created by Prashant Gami on 22/01/2015.
//  Copyright (c) 2015 Pectera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "PCDataDownloader.h"
#import "PCCountryFact.h"

@interface PacteraTestTests : XCTestCase

@end

@implementation PacteraTestTests

-(void)testPCCountryFact {
    PCCountryFact *fact = [[PCCountryFact alloc] initWithDictionary:@{ @"title":@"title",
                                                                       @"description":@"description",
                                                                       @"imageHref":@"imageHref"}];
    XCTAssert([fact.factTitle isEqualToString:@"title"]);
    XCTAssert([fact.factDescription isEqualToString:@"description"]);
    XCTAssert([fact.factImageUrl isEqualToString:@"imageHref"]);
}

-(void)testEmptyPCCountryFact {
    PCCountryFact *fact = [[PCCountryFact alloc] initWithDictionary:@{ @"title":@"",
                                                                       @"description":@"",
                                                                       @"imageHref":@"" }];
    XCTAssert([fact isEmpty]);
}

-(void)testDataConnectivity {
    [PCDataDownloader loadCountryDatFromServer:^(NSString *listTitle, NSArray *factArray) {
        XCTAssertNotNil(listTitle);
        XCTAssertNotNil(factArray);
    } failure:^(NSError *error) {
        XCTAssertNil(error);
    }];
}

@end
