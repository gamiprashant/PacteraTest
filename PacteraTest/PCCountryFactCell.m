//
//  PCCountryFactCell.m
//  PacteraTest
//
//  Created by Prashant Gami on 22/01/2015.
//  Copyright (c) 2015 Pectera. All rights reserved.
//

#import "PCCountryFactCell.h"
#import "PureLayout.h"
#import "PCCommonUtils.h"
#import "UIImageView+AFNetworking.h"

///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
@interface PCCountryFactCell ()

@property (nonatomic, strong) UILabel *factTitle;
@property (nonatomic, strong) UILabel *factLabel;
@property (nonatomic, strong) UIImageView *factImageView;

@end

///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
@implementation PCCountryFactCell

///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.didSetupConstraints = NO;
        
        self.factTitle = [UILabel newAutoLayoutView];
        self.factTitle.font = [PCCommonUtils getHeaderFont];
        self.factTitle.textAlignment = NSTextAlignmentLeft;
        self.factTitle.lineBreakMode = NSLineBreakByWordWrapping;
        self.factTitle.numberOfLines = 0;
        self.factTitle.preferredMaxLayoutWidth = 320.;
        [self.contentView addSubview:self.factTitle];
        
        self.factImageView = [UIImageView newAutoLayoutView];
        self.factImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.factImageView];
        
        self.factLabel = [UILabel newAutoLayoutView];
        self.factLabel.font = [PCCommonUtils getStandardFont];
        self.factLabel.textAlignment = NSTextAlignmentLeft;
        self.factLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.factLabel.numberOfLines = 0;
        self.factLabel.preferredMaxLayoutWidth = 320.;
        [self.contentView addSubview:self.factLabel];
    }
    return self;
}

///////////////////////////////////////////////////////////////
- (void)updateConstraints
{
    if(!self.didSetupConstraints) {
        // Note: if the constraints you add below require a larger cell size than the current size (which is likely to be the default size {320, 44}), you'll get an exception.
        // As a fix, you can temporarily increase the size of the cell's contentView so that this does not occur using code similar to the line below.
        //      See here for further discussion: https://github.com/Alex311/TableCellWithAutoLayout/commit/bde387b27e33605eeac3465475d2f2ff9775f163#commitcomment-4633188
        self.contentView.bounds = CGRectMake(0.0f, 0.0f, 99999.0f, 99999.0f);
        
        [self.factTitle autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:marginVertical];
        [self.factTitle autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:marginHorizontal];
        
        [self.factTitle autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:marginHorizontal relation:NSLayoutRelationGreaterThanOrEqual];
        
        [self.factImageView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.factTitle withOffset:marginVertical];
        [self.factImageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.factImageView autoSetDimension:ALDimensionHeight toSize:100.];
        
        [self.factLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.factImageView withOffset:marginVertical];
        [self.factLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:marginHorizontal];
        [self.factLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:marginHorizontal relation:NSLayoutRelationGreaterThanOrEqual];
        [self.factLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:marginVertical];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}
///////////////////////////////////////////////////////////////
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // Make sure the contentView does a layout pass here so that its subviews have their frames set, which we
    // need to use to set the preferredMaxLayoutWidth below.
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
}

///////////////////////////////////////////////////////////////
-(void) setFactWithDictionary:(NSDictionary*)factDict {
    self.fact = [[PCCountryFact alloc] initWithDictionary:factDict];
    [self.factTitle setText:self.fact.factTitle];
    [self.factLabel setText:self.fact.factDescription];
    
    if(![self.fact.factImageUrl isEqualToString:@""]) {
        [self.factImageView setImageWithURL:[NSURL URLWithString:self.fact.factImageUrl]    //This will Lazy Load the Image
                           placeholderImage:[UIImage imageNamed:@"flag"]];
    } else {
        [self.factImageView setImage:[UIImage imageNamed:@"flag"]];
    }
}

@end
