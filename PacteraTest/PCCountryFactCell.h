//
//  PCCountryFactCell.h
//  PacteraTest
//
//  Created by Prashant Gami on 22/01/2015.
//  Copyright (c) 2015 Pectera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCCountryFact.h"

@interface PCCountryFactCell : UITableViewCell

@property (nonatomic, assign) BOOL didSetupConstraints;
@property (nonatomic, strong) PCCountryFact *fact;

-(void) setFactWithDictionary:(NSDictionary*)factDict;

@end
