//  MMProjectDetailViewController.m
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
#import "MMProjectDetailViewController.h"
#import "MMAddTimeViewController.h"
#import "MMClient.h"
#import "MMEditProjectViewController.h"
#import "MMProject.h"
#import "MMTime.h"
#import "MMTimeDetailViewController.h"
@implementation MMProjectDetailViewController
@synthesize NameLabel;
@synthesize RateLabel;
@synthesize ThisProject;
@synthesize TimesTableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(EditProject)];
    [[self navigationItem] setRightBarButtonItem:editButton];
    
    // We have a project to load
    NSNumber *rate = [[self ThisProject] HourlyRate];
    MMPayRateType payType = kMMPayRateHourly;
    if (!rate) {
        rate = [[self ThisProject] ProjectLumpSum];
        payType = kMMPayRateLumpSum;
    }
    if (!rate) {
        MMClient *owner = [[self ThisProject] OwningClient];
        rate = [owner HourlyRate];
        payType = kMMPayRateHourly;
    }
    NSString *rateType = [NSString stringWithFormat:@"/hr"];
    if (payType == kMMPayRateLumpSum) {
        rateType = @"";
    }
    [[self RateLabel]       setText:[NSString stringWithFormat:@"Rate: $%.02f%@", [rate floatValue], rateType]];
    [[self NameLabel]       setText:[NSString stringWithFormat:@"Name: %@", [[self ThisProject] Name]]];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    MMClient *thisClient = [[self ThisProject] OwningClient];
    [self setTitle:[thisClient Name]];
    
    NSSortDescriptor *sortByDate = [[NSSortDescriptor alloc] initWithKey:@"StartTimeStamp" ascending:YES];
    [[[self ThisProject] LoggedTimes] sortUsingDescriptors:@[sortByDate]];
    [[self TimesTableView] reloadData];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - My Button Press methods
- (void)EditProject {
    MMEditProjectViewController *detailVC = [[MMEditProjectViewController alloc] initWithNibName:@"MMEditProjectViewController" bundle:nil];
    [detailVC setThisProject:[self ThisProject]];
    [[self navigationController] pushViewController:detailVC animated:YES];
}

#pragma mark - UITableView Data Source methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[self ThisProject] LoggedTimes] count] + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    int row = [indexPath row];
    if (row == 0) {
        // This is the "Add New Project" cell
        UIButton *b = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [cell setAccessoryView:b];
        [[cell textLabel] setText:@"Log New Time..."];
    } else {
        row = row - 1;
        [cell setAccessoryView:nil];
        MMTime *cellTime = [[[self ThisProject] LoggedTimes] objectAtIndex:row];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM/dd/yyyy"];
        NSString *startDate = [formatter stringFromDate:[cellTime StartTimeStamp]];
        NSString *endDate   = [formatter stringFromDate:[cellTime StopTimeStamp]];
        if ([startDate isEqualToString:endDate]) {
            // Start and end on same day
            [[cell textLabel] setText:[NSString stringWithFormat:@"Date: %@", startDate]];
        } else {
            // Spans midnight
            [[cell textLabel] setText:[NSString stringWithFormat:@"Dates: %@-%@", startDate, endDate]];
        }
        [[cell detailTextLabel] setText:[NSString stringWithFormat:@"Total Time: %@", [cellTime TimeString]]];
        if ([cellTime Invoiced]) {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        } else {
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
    }
    return cell;
}
#pragma mark - UITableView Delegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[self TimesTableView] deselectRowAtIndexPath:indexPath animated:YES];
    int row = [indexPath row];
    if (row == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Manual or Timer?" message:@"Would you like to use a timer or enter your start/stop times manually?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Enter Manually", @"Use Timer", nil];
        [alert show];
    } else {
        row = row - 1;
        // Select this time (auto-edit)
        MMTimeDetailViewController *detailVC = [[MMTimeDetailViewController alloc] initWithNibName:@"MMTimeDetailViewController" bundle:nil];
        MMTime *cellTime = [[[self ThisProject] LoggedTimes] objectAtIndex:row];
        [detailVC setThisTime:cellTime];
        [[self navigationController] pushViewController:detailVC animated:YES];
    }
    
}
#pragma mark - UIActionSheet Delegate method
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"Use Timer"]) {
        // Add a new time
        MMAddTimeViewController *detailVC = [[MMAddTimeViewController alloc] initWithNibName:@"MMAddTimeViewController" bundle:nil];
        [detailVC setThisProject:[self ThisProject]];
        [[self navigationController] pushViewController:detailVC animated:YES];
    } else {
        MMTimeDetailViewController *detailVC = [[MMTimeDetailViewController alloc] initWithNibName:@"MMTimeDetailViewController" bundle:nil];
        [detailVC setThisProject:[self ThisProject]];
        [[self navigationController] pushViewController:detailVC animated:YES];
    }
}
@end