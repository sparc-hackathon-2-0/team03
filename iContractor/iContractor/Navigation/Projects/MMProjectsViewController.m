//  MMProjectsViewController.m
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
#import "MMProjectsViewController.h"
#import "MMProject.h"
#import "MMProjectDetailViewController.h"
@implementation MMProjectsViewController
@synthesize ClientName;
@synthesize ProjectsList;
@synthesize ProjectsTableView;
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - UITableView Data Source methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self ProjectsList] count] + 1;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self ClientName];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if ([indexPath row] == 0) {
        // This is the "Add New Project" cell
        UIButton *b = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [cell setAccessoryView:b];
        [[cell textLabel] setText:@"Add New Project"];
    } else {
        [cell setAccessoryView:nil];
        [[cell textLabel] setText:[(MMProject *)[[self ProjectsList] objectAtIndex:[indexPath row]] Name]];
    }
    return cell;
}
#pragma mark - UITableView Delegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[self tableView] deselectRowAtIndexPath:indexPath animated:YES];
    MMProjectDetailViewController *detailVC = [[MMProjectDetailViewController alloc] initWithNibName:@"MMProjectDetailViewController" bundle:nil];
    if ([indexPath row] == 0) {
        // Add a new project
        
    } else {
        // Select this project
        
    }
    [[self navigationController] pushViewController:detailVC animated:YES];
}
@end