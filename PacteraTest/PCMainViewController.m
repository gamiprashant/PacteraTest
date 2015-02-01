//
//  PCMainViewController.m
//  PacteraTest
//
//  Created by Prashant Gami on 22/01/2015.
//  Copyright (c) 2015 Pectera. All rights reserved.
//

#import "PCMainViewController.h"
#import "PCCountryFactCell.h"
#import "PCCountryFactWithImageCell.h"
#import "PCDataDownloader.h"
#import "PureLayout.h"

static NSString *CellIdCountryFact = @"CellIdCountryFact";
static NSString *CellIdCountryFactWithImage = @"CellIdCountryFactWithImage";

///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
@interface PCMainViewController ()

// A dictionary of offscreen cells that are used within the tableView:heightForRowAtIndexPath: method to
// handle the height calculations. These are never drawn onscreen. The dictionary is in the format:
//      { NSString *reuseIdentifier : UITableViewCell *offscreenCell, ... }
@property (strong, nonatomic) NSMutableDictionary *offscreenCells;
@property (nonatomic, strong) NSArray *factArray;
@property (nonatomic, strong) UIBarButtonItem *refreshBt;

@end

///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
@implementation PCMainViewController

///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
#pragma mark - LifeCycle

///////////////////////////////////////////////////////////////
- (id)init {
    self = [super init];
    if (self) {
        self.offscreenCells = [NSMutableDictionary dictionary];
        self.factArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

///////////////////////////////////////////////////////////////
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.allowsSelection = NO;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerClass:[PCCountryFactCell class] forCellReuseIdentifier:CellIdCountryFact];
    [self.tableView registerClass:[PCCountryFactWithImageCell class] forCellReuseIdentifier:CellIdCountryFactWithImage];
    
    self.view.backgroundColor = [UIColor whiteColor];

    //Allow Pull to Refresh
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(loadCountryData) forControlEvents:UIControlEventValueChanged];
    
    self.refreshBt = [[UIBarButtonItem alloc]
                               initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                               target:self
                               action:@selector(loadCountryData)];
    self.navigationItem.rightBarButtonItem = self.refreshBt;

    
    // Setting the estimated row height prevents the table view from calling tableView:heightForRowAtIndexPath: for
    // every row in the table on first load; it will only be called as cells are about to scroll onscreen.
    // This is a major performance optimization.
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
}

- (void)viewDidAppear:(BOOL)animated {
    [self loadCountryData];
}


///////////////////////////////////////////////////////////////
- (void) updateViewConstraints {
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    [super updateViewConstraints];
}

///////////////////////////////////////////////////////////////
- (void)viewWillLayoutSubviews
{
    // When this view controller is presented through a UINavigationController, the updateViewContraints will not be
    // called automatically. The following is required to make them called.
    [super viewWillLayoutSubviews];
    [self.view setNeedsUpdateConstraints];
}

///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
#pragma mark - Action Handlers

-(void) loadCountryData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showLoading];
        [PCDataDownloader loadCountryDatFromServer:^(NSString *listTitle, NSArray *factArray) {
            [self hideLoading];
            [self.refreshControl endRefreshing];
            
            if(listTitle) {
                [self.navigationItem setTitle:listTitle];
            }
            if(factArray) {
                self.factArray = factArray;
                [self.tableView reloadData];
                [self.refreshControl endRefreshing];
            }
        } failure:^(NSError *error) {
            [self hideLoading];
            [self.refreshControl endRefreshing];
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"refreshFailTitle", nil)
                                        message:NSLocalizedString(@"refreshFailMessage", nil)
                                       delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        }];
    });
    
}


///////////////////////////////////////////////////////////////
-(void)showLoading {
    UIActivityIndicatorView *activityIndicator =
    [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [activityIndicator startAnimating];
    [activityIndicator setColor:[UIColor grayColor]];
    UIBarButtonItem *activityItem =
    [[UIBarButtonItem alloc] initWithCustomView:activityIndicator];
    [activityIndicator release];
    self.navigationItem.rightBarButtonItem = activityItem;
    [activityItem release];
}

///////////////////////////////////////////////////////////////
-(void)hideLoading {
    if(self.refreshBt == nil) {
        self.refreshBt = [[UIBarButtonItem alloc]
                          initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                          target:self
                          action:@selector(loadCountryData)];
    }
    self.navigationItem.rightBarButtonItem = self.refreshBt;
}

///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
#pragma mark - UITableViewDataSource methods


///////////////////////////////////////////////////////////////
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PCCountryFact *fact = [self.factArray objectAtIndex:indexPath.row];

    //Handle Empty Data
    if([fact isEmpty]) {
        return 0.0;
    }
    
    UITableViewCell *cell;
    if([fact.factImageUrl isEqualToString:@""]) {
        cell = [self.offscreenCells objectForKey:CellIdCountryFact];
        if(cell == nil) {
            cell = [[PCCountryFactCell alloc] init];
            [self.offscreenCells setObject:cell forKey:CellIdCountryFact];
        }
        [(PCCountryFactCell*)cell setDataWithFact:fact];
    } else {
        cell = [self.offscreenCells objectForKey:CellIdCountryFactWithImage];
        if(cell == nil) {
            cell = [[PCCountryFactWithImageCell alloc] init];
            [self.offscreenCells setObject:cell forKey:CellIdCountryFactWithImage];
        }
        [(PCCountryFactWithImageCell*)cell setDataWithFact:fact];
    }
    
    [fact release];
    
    // Make sure the constraints have been added to this cell, since it may have just been created from scratch

    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    // The cell's width must be set to the same size it will end up at once it is in the table view.
    // This is important so that we'll get the correct height for different table view widths, since our cell's
    // height depends on its width due to the multi-line UILabel word wrapping. Don't need to do this above in
    // -[tableView:cellForRowAtIndexPath:] because it happens automatically when the cell is used in the table view.
    cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
    // NOTE: if you are displaying a section index (e.g. alphabet along the right side of the table view), or
    // if you are using a grouped table view style where cells have insets to the edges of the table view,
    // you'll need to adjust the cell.bounds.size.width to be smaller than the full width of the table view we just
    // set it to above. See http://stackoverflow.com/questions/3647242 for discussion on the section index width.
    
    // Do the layout pass on the cell, which will calculate the frames for all the views based on the constraints
    // (Note that the preferredMaxLayoutWidth is set on multi-line UILabels inside the -[layoutSubviews] method
    // in the UITableViewCell subclass
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    // Get the actual height required for the cell
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    // Add an extra point to the height to account for the cell separator, which is added between the bottom
    // of the cell's contentView and the bottom of the table view cell.
    height += 1;
    
    return height;
}


///////////////////////////////////////////////////////////////
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.factArray.count;
}


///////////////////////////////////////////////////////////////
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    PCCountryFact *fact = [self.factArray objectAtIndex:indexPath.row];

    UITableViewCell *cell;
    if([fact.factImageUrl isEqualToString:@""]) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdCountryFact];
        [(PCCountryFactCell*)cell setDataWithFact:fact];
    } else {
        cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdCountryFactWithImage];
        [(PCCountryFactWithImageCell*)cell setDataWithFact:fact];
    }
    
    //Need this to make sure that cell is sized correctly for the content
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    return cell;
}

///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
#pragma mark - Cleanup

///////////////////////////////////////////////////////////////
-(void)dealloc {
    [self.refreshBt release];
    self.refreshBt = nil;
    [self.refreshBt dealloc];
    [self.factArray release];
    self.factArray = nil;
    [self.factArray dealloc];
    [self.offscreenCells release];
    self.offscreenCells = nil;
    [self.offscreenCells dealloc];
    [super dealloc];
}
@end
