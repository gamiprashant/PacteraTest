//
//  PCDataDownloader.m
//  PacteraTest
//
//  Created by Prashant Gami on 22/01/2015.
//  Copyright (c) 2015 Pectera. All rights reserved.
//

#import "PCDataDownloader.h"
#import "AFHTTPRequestOperationManager.h"
#import "PCCountryFact.h"

@implementation PCDataDownloader


+(void) loadCountryDatFromServer:(void (^)(NSString* listTitle, NSArray* factArray))success
                         failure:(void (^)(NSError* error))failure {
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]
                                              initWithBaseURL:[NSURL URLWithString:kCountryDataUrl]];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",
                                                             @"application/json", nil];
    
    AFHTTPRequestOperation *apiRequest = [manager GET:kCountryDataUrl parameters:nil
                                              success:^(AFHTTPRequestOperation *operation,
                                                        id responseObject) {
        
                                                  if(responseObject == nil) {
                                                      failure(nil);
                                                      return;
                                                  }
                                                  NSString *listTitle = [responseObject objectForKey:@"title"];
                                                  NSArray *rows = [responseObject objectForKey:@"rows"];
                                                  NSMutableArray *facts = [[NSMutableArray alloc] init];
                                                  for(NSDictionary *row in rows) {
                                                      PCCountryFact *fact = [[PCCountryFact alloc] initWithDictionary:row];
                                                      [facts addObject:fact];
                                                      [fact autorelease];
                                                  }
                                                  [facts autorelease];
                                                  success(listTitle, facts);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        failure(error);
    }];
    [apiRequest start];
    
    [manager release];
}

@end
