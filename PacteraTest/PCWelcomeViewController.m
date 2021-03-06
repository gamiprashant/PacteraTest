//
//  PCWelcomeViewController.m
//  PacteraTest
//
//  Created by Prashant Gami on 22/01/2015.
//  Copyright (c) 2015 Pectera. All rights reserved.
//

#import "PCWelcomeViewController.h"
#import "UIView+AutoLayout.h"
#import "PCCommonUtils.h"
#import "PCConstants.h"
#import "PCMainViewController.h"

///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
@interface PCWelcomeViewController ()

@property (nonatomic, strong) UILabel *mainLabel;
@property (nonatomic, strong) UILabel *copyrightLabel;
@property (nonatomic, strong) NSMutableArray *constraints;

@end

///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
@implementation PCWelcomeViewController

///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
#pragma mark - LifeCycle

///////////////////////////////////////////////////////////////
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.mainLabel = [UILabel newAutoLayoutView];
    self.mainLabel.font = [PCCommonUtils getTitleFont];
    self.mainLabel.text = NSLocalizedString(@"appName", nil);
    [self.view addSubview:self.mainLabel];
    
    self.copyrightLabel = [UILabel newAutoLayoutView];
    self.copyrightLabel.font = [PCCommonUtils getDescriptionFont];
    self.copyrightLabel.text = NSLocalizedString(@"copyrightText", nil);
    [self.view addSubview:self.copyrightLabel];
}

///////////////////////////////////////////////////////////////
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3. * NSEC_PER_SEC),
                   dispatch_get_main_queue(), ^{
                       PCMainViewController *vc = [[PCMainViewController alloc] init];
                       self.navigationController.viewControllers = @[vc];
                       [vc release];
                   });
}

///////////////////////////////////////////////////////////////
- (void) updateViewConstraints {
    
    self.constraints = [[NSMutableArray alloc] init];
    
    [self.constraints addObjectsFromArray:[self.mainLabel autoCenterInSuperview]];
    
    [self.constraints addObject:[self.copyrightLabel autoAlignAxisToSuperviewAxis:ALAxisVertical]];
    [self.constraints addObject:[self.copyrightLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.view
                          withOffset:-20]];
    [super updateViewConstraints];
}

///////////////////////////////////////////////////////////////
- (void)viewWillLayoutSubviews
{
    // When this view controller is presented through a UINavigationController,
    // the updateViewContraints will not be
    // called automatically. The following is required to make them called.
    [super viewWillLayoutSubviews];
    [self.view setNeedsUpdateConstraints];
}

-(void) dealloc {
    [self.mainLabel release];
    self.mainLabel = nil;
    [self.copyrightLabel release];
    self.copyrightLabel = nil;
    [self.mainLabel dealloc];
    [self.copyrightLabel dealloc];
    [self.constraints release];
    self.constraints = nil;
    [self.constraints dealloc];
    [super dealloc];
}

@end
