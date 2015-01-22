//
//  PCWelcomeViewController.m
//  PacteraTest
//
//  Created by Prashant Gami on 22/01/2015.
//  Copyright (c) 2015 Pectera. All rights reserved.
//

#import "PCWelcomeViewController.h"
#import "PureLayout.h"
#import "PCCommonUtils.h"
#import "PCConstants.h"
#import "PCMainViewController.h"

///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
@interface PCWelcomeViewController ()

@property (nonatomic, strong) UILabel *mainLabel;
@property (nonatomic, strong) UILabel *copyrightLabel;

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
                   });
}

///////////////////////////////////////////////////////////////
- (void) updateViewConstraints {
    
    [self.mainLabel autoCenterInSuperview];
    
    [self.copyrightLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.copyrightLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.view
                          withOffset:-20];
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

@end
