//
//  PCCountryFactWithImageCell.h
//  CanadaFacts
//
//  Created by Prashant Gami on 2/02/2015.
//  Copyright (c) 2015 Pectera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCCountryFact.h"

@interface PCCountryFactWithImageCell : UITableViewCell

@property (nonatomic, assign) BOOL didSetupConstraints;

-(void) setDataWithFact:(PCCountryFact*)fact forHeightOnly:(BOOL)heightOnly;
@end
