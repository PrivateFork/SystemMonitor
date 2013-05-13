//
//  RootTableViewController.m
//  ActivityMonitor++
//
//  Created by st on 07/05/2013.
//  Copyright (c) 2013 st. All rights reserved.
//

#import "AMLog.h"
#import "RootTableViewController.h"

typedef enum {
    VIEW_CTRL_GENERAL=0,
    VIEW_CTRL_CPU,
    VIEW_CTRL_PROCESSES,
    VIEW_CTRL_RAM,
    VIEW_CTRL_GPU,
    VIEW_CTRL_MAX
} ViewCtrl_t;

@interface RootTableViewController ()
- (void)switchView:(ViewCtrl_t)viewCtrl;
@end

@implementation RootTableViewController

static const NSString *ViewCtrlIdentifiers[] = {
    [VIEW_CTRL_GENERAL]     = @"GeneralViewController",
    [VIEW_CTRL_CPU]         = @"CPUViewController",
    [VIEW_CTRL_PROCESSES]   = @"TODO",
    [VIEW_CTRL_RAM]         = @"TODO",
    [VIEW_CTRL_GPU]         = @"GPUViewController"
};

#pragma mark - override

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self switchView:VIEW_CTRL_GENERAL];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                animated:NO
                          scrollPosition:UITableViewScrollPositionTop];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private

- (void)switchView:(ViewCtrl_t)viewCtrl
{
    NSParameterAssert(viewCtrl < VIEW_CTRL_MAX);
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:(NSInteger)viewCtrl inSection:0]
                                animated:NO
                          scrollPosition:UITableViewScrollPositionTop];
    
    NSString *identifier = (NSString*)ViewCtrlIdentifiers[viewCtrl];
    UIViewController *ctrl = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    self.splitViewController.viewControllers = [NSArray arrayWithObjects:self.navigationController, ctrl, nil];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    assert(cell);
    
    NSString *cellBg = nil;
    if (indexPath.row == 0)
    {
        cellBg = @"TopRootCell-88.png";
    }
    else
    {
        cellBg = @"FollowingRootCell-88";
    }
    [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:cellBg]]];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ViewCtrl_t viewCtrl = (ViewCtrl_t)indexPath.row;
    [self switchView:viewCtrl];
}

@end