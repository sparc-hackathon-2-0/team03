//  MMTimeViewController.m
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
#import "MMTimeViewController.h"
#import "MMAppDelegate.h"
#import "MMClient.h"
#import "MMClientDetailViewController.h"
#import "MMProject.h"
#import "MMProjectDetailViewController.h"
@implementation MMTimeViewController
@synthesize Delegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDelegate:(MMAppDelegate *)[[UIApplication sharedApplication] delegate]];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}
#pragma mark - UITableView Data Source methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            // This is the clients list
        {
            if ([[[self Delegate] ClientList] count] == 0) {
                return 1;
            } else {
                return [[[self Delegate] ClientList] count];
            }
        }
            break;
        case 1:
            // This is the projects list
        {
            int count = 0;
            for (MMClient *client in [[self Delegate] ClientList]) {
                count = count + [[client Projects] count];
            }
            if (count == 0) {
                return 1;
            } else {
                return count;
            }
        }
            break;
        default:
            return 0;
            break;
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Select a client...";
            break;
        case 1:
            return @"Select a project...";
            break;
        default:
            return @"";
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *clientIdentifier = @"Client";
    static NSString *projIdentifier = @"Project";
    int section = [indexPath section];
    int row = [indexPath row];
    switch (section) {
        case 0:
            // This is a client
        {
            if ([[[self Delegate] ClientList] count] == 0) {
                // This is a placeholder
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClientPlaceholder"];
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ClientPlaceholder"];
                }
                [cell setSelectionStyle:UITableViewCellEditingStyleNone];
                [cell setUserInteractionEnabled:NO];
                [[cell textLabel] setText:@"No clients in system..."];
                return cell;
            } else {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:clientIdentifier];
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:clientIdentifier];
                }
                [[cell textLabel] setText:[[[[self Delegate] ClientList] objectAtIndex:row] Name]];
                return cell;
            }
        }
            break;
        case 1:
            // This is a project
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:projIdentifier];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:projIdentifier];
            }
            int index = 0;
            for (MMClient *client in [[self Delegate] ClientList]) {
                for (MMProject *project in [client Projects]) {
                    if (index == row) {
                        // This is the project
                        [[cell textLabel] setText:[project Name]];
                        [[cell detailTextLabel] setText:[client Name]];
                        return cell;
                    } else {
                        index = index + 1;
                    }
                }
            }
            // If I get here, there are no projects to show
            // This is a placeholder
            cell = [tableView dequeueReusableCellWithIdentifier:@"ProjectPlaceholder"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProjectPlaceholder"];
            }
            [cell setSelectionStyle:UITableViewCellEditingStyleNone];
            [cell setUserInteractionEnabled:NO];
            [[cell textLabel] setText:@"No projects in system..."];
            return cell;
        }
        default:
            return [[UITableViewCell alloc] init];
            break;
    }
}
#pragma mark - UITableView Delegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[self tableView] deselectRowAtIndexPath:indexPath animated:YES];
    switch ([indexPath section]) {
        case 0:
            // They selected a client
        {
            MMClient *client = [[[self Delegate] ClientList] objectAtIndex:[indexPath row]];
            MMClientDetailViewController *detailVC = [[MMClientDetailViewController alloc] initWithNibName:@"MMClientDetailViewController" bundle:nil];
            [detailVC setThisClient:client];
            [[self navigationController] pushViewController:detailVC animated:YES];
        }
            break;
        case 1:
            // They selected a project
        {
            MMProject *thisProject;
            int index = 0;
            for (MMClient *client in [[self Delegate] ClientList]) {
                for (MMProject *project in [client Projects]) {
                    if (index == [indexPath row]) {
                        // This is the project
                        thisProject = project;
                        MMProjectDetailViewController *detailVC = [[MMProjectDetailViewController alloc] initWithNibName:@"MMProjectDetailViewController" bundle:nil];
                        [detailVC setThisProject:thisProject];
                        [[self navigationController] pushViewController:detailVC animated:YES];
                        return;
                    } else {
                        index = index + 1;
                    }
                }
            }
        }
            break;
        default:
            break;
    }
}
@end