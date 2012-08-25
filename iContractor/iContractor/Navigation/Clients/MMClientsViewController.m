//  MMClientsViewController.m
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
#import "MMClientsViewController.h"
#import "MMAddClientViewController.h"
#import "MMAppDelegate.h"
#import "MMClient.h"
#import "MMClientDetailViewController.h"
@implementation MMClientsViewController
@synthesize Delegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Clients"];
    [self setDelegate:(MMAppDelegate *)[[UIApplication sharedApplication] delegate]];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    [[self tableView] reloadData];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - UITableView Data Source methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[self Delegate] ClientList] count] + 1;
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
        [[cell textLabel] setText:@"Add New Client"];
    } else {
        row = row - 1;
        [cell setAccessoryView:nil];
        [[cell textLabel] setText:[(MMClient *)[[[self Delegate] ClientList] objectAtIndex:row] Name]];
        [[cell detailTextLabel] setText:[(MMClient *)[[[self Delegate] ClientList] objectAtIndex:row] PrimaryContact]];
    }
    return cell;
}
#pragma mark - UITableView Delegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[self tableView] deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([indexPath row] == 0) {
        // Add a new client
        MMAddClientViewController *detailVC = [[MMAddClientViewController alloc] initWithNibName:@"MMAddClientViewController" bundle:nil];
        [[self navigationController] pushViewController:detailVC animated:YES];
    } else {
        // Select this client
        MMClientDetailViewController *detailVC = [[MMClientDetailViewController alloc] initWithNibName:@"MMClientDetailViewController" bundle:nil];
        int row = [indexPath row] - 1;
        [detailVC setThisClient:[[[self Delegate] ClientList] objectAtIndex:row]];
        [[self navigationController] pushViewController:detailVC animated:YES];
    }
    
}
@end