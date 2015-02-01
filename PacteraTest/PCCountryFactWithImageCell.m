//
//  PCCountryFactWithImageCell.m
//  CanadaFacts
//
//  Created by Prashant Gami on 2/02/2015.
//  Copyright (c) 2015 Pectera. All rights reserved.
//

#import "PCCountryFactWithImageCell.h"
#import "PureLayout.h"
#import "PCCommonUtils.h"
#import "UIImageView+AFNetworking.h"

///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
@interface PCCountryFactWithImageCell ()

@property (nonatomic, strong) UILabel *factTitle;
@property (nonatomic, strong) UILabel *factLabel;
@property (nonatomic, strong) UIImageView *factImageView;

@end

@implementation PCCountryFactWithImageCell

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
        self.factTitle.textColor = [[UIColor blueColor] autorelease];
        self.factTitle.numberOfLines = 0;
        self.factTitle.preferredMaxLayoutWidth = self.bounds.size.width;
        [self.contentView addSubview:self.factTitle];
        
        self.factImageView = [UIImageView newAutoLayoutView];
        self.factImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.factImageView];
        
        self.factLabel = [UILabel newAutoLayoutView];
        self.factLabel.font = [PCCommonUtils getStandardFont];
        self.factLabel.textAlignment = NSTextAlignmentLeft;
        self.factLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.factLabel.numberOfLines = 0;
        self.factLabel.preferredMaxLayoutWidth = self.bounds.size.width;
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
        [self.factImageView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:marginHorizontal];
        [self.factImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:marginVertical relation:NSLayoutRelationGreaterThanOrEqual];
        [self.factImageView autoSetDimensionsToSize:CGSizeMake(100., 100.)];

        [self.factLabel autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:self.factImageView withOffset:-marginHorizontal];
        [self.factLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:marginHorizontal];
        [self.factLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.factTitle withOffset:marginVertical];
        [self.factLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:marginVertical relation:NSLayoutRelationGreaterThanOrEqual];
        [self.factLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:marginHorizontal relation:NSLayoutRelationGreaterThanOrEqual];
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
-(void) setDataWithFact:(PCCountryFact*)fact {
    [self.factTitle setText:fact.factTitle];
    [self.factLabel setText:fact.factDescription];
    [self.factImageView setImageWithURL:[NSURL URLWithString:fact.factImageUrl]    //This will Lazy Load the Image
                           placeholderImage:[UIImage imageNamed:@"flag"]];
}

-(void)dealloc {
    [self.factTitle release];
    self.factTitle = nil;
    [self.factTitle dealloc];
    [self.factLabel release];
    self.factLabel = nil;
    [self.factLabel dealloc];
    [self.factImageView release];
    self.factImageView = nil;
    [self.factImageView dealloc];
    [super dealloc];
    
}

@end
