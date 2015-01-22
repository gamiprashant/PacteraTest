//
//  PCDataDownloader.m
//  PacteraTest
//
//  Created by Prashant Gami on 22/01/2015.
//  Copyright (c) 2015 Pectera. All rights reserved.
//

#import "PCDataDownloader.h"
#import "AFHTTPRequestOperationManager.h"

@implementation PCDataDownloader


+(void) loadCountryDatFromServer:(void (^)(NSDictionary* countryData))success
                         failure:(void (^)(NSError* error))failure {
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kCountryDataUrl]];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    AFHTTPRequestOperation *apiRequest = [manager GET:kCountryDataUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
    [apiRequest start];
}

@end
