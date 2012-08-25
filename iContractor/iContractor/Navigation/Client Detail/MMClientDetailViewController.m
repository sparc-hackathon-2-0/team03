//  MMClientDetailViewController.m
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
#import "MMClientDetailViewController.h"
#import "MMAddProjectViewController.h"
#import "MMButton.h"
#import "MMClient.h"
#import "MMEditClientViewController.h"
#import "MMProject.h"
#import "MMProjectDetailViewController.h"
@implementation MMClientDetailViewController
@synthesize CallClient;
@synthesize ContactLabel;
@synthesize EmailClient;
@synthesize EmailLabel;
@synthesize NumberLabel;
@synthesize ProjectsTableView;
@synthesize RateLabel;
@synthesize SendInvoice;
@synthesize ThisClient;
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setTitle:[[self ThisClient] Name]];
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(EditClient)];
    [[self navigationItem] setRightBarButtonItem:editButton];
    
    [[self ContactLabel]        setText:[NSString stringWithFormat:@"Contact: %@",  [[self ThisClient] PrimaryContact]]];
    [[self RateLabel]           setText:[NSString stringWithFormat:@"Rate: $%.02f/hr", [[[self ThisClient] HourlyRate] floatValue]]];
    
    [[self CallClient]      setTitle:[[self ThisClient] Phone] forState:UIControlStateNormal];
    [[[self CallClient]     titleLabel] setAdjustsFontSizeToFitWidth:YES];
    [[[self CallClient]     titleLabel] setMinimumFontSize:8.0];
    [[self CallClient]      setButtonBackgroundColor:[UIColor grayColor]];
    [[self CallClient]      setButtonBackground];
    
    [[self EmailClient]     setTitle:[[self ThisClient] Email] forState:UIControlStateNormal];
    [[[self EmailClient]    titleLabel] setAdjustsFontSizeToFitWidth:YES];
    [[[self EmailClient]    titleLabel] setMinimumFontSize:10.0];
    [[self EmailClient]     setButtonBackgroundColor:[UIColor grayColor]];
    [[self EmailClient]     setButtonBackground];
    
    [[self SendInvoice]     setButtonBackgroundColor:[UIColor grayColor]];
    [[self SendInvoice]     setButtonBackground];
    
    [[self ProjectsTableView] reloadData];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - My Button Press methods
- (void)EditClient {
    MMEditClientViewController *detailVC = [[MMEditClientViewController alloc] initWithNibName:@"MMEditClientViewController" bundle:nil];
    [detailVC setThisClient:[self ThisClient]];
    [[self navigationController] pushViewController:detailVC animated:YES];
}
- (IBAction)CallPressed:(id)sender {
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"tel://%@", [[self ThisClient] Phone]]];
    [[UIApplication sharedApplication] openURL:url];
}
- (IBAction)EmailPressed:(id)sender {
    MFMailComposeViewController *vc = [[MFMailComposeViewController alloc] init];
    [vc setMailComposeDelegate:self];
    [vc setSubject:@"Message from Contractor"];
    [vc setToRecipients:@[[[self ThisClient] Email]]];
    [vc setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentModalViewController:vc animated:YES];
}
- (IBAction)InvoicePressed:(id)sender {
    MFMailComposeViewController *vc = [[MFMailComposeViewController alloc] init];
    [vc setMailComposeDelegate:self];
    [vc setSubject:@"Invoice from Contractor"];
    [vc setToRecipients:@[[[self ThisClient] Email]]];
    [vc setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentModalViewController:vc animated:YES];
}
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissModalViewControllerAnimated:YES];
}
#pragma mark - UITableView Data Source methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[self ThisClient] Projects] count] + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    int row = [indexPath row];
    if (row == 0) {
        // This is the "Add New Project" cell
        UIButton *b = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [cell setAccessoryView:b];
        [[cell textLabel] setText:@"Add New Project"];
    } else {
        row = row - 1;
        MMProject *thisProject = [[[self ThisClient] Projects] objectAtIndex:row];
        [cell setAccessoryView:nil];
        [[cell textLabel] setText:[thisProject Name]];
    }
    return cell;
}
#pragma mark - UITableView Delegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[self ProjectsTableView] deselectRowAtIndexPath:indexPath animated:YES];
    int row = [indexPath row];
    if (row == 0) {
        // Add a new project
        MMAddProjectViewController *detailVC = [[MMAddProjectViewController alloc] initWithNibName:@"MMAddProjectViewController" bundle:nil];
        [detailVC setThisClient:[self ThisClient]];
        [[self navigationController] pushViewController:detailVC animated:YES];
    } else {
        // Select this project
        row = row - 1;
        MMProject *thisProject = [[[self ThisClient] Projects] objectAtIndex:row];
        MMProjectDetailViewController *detailVC = [[MMProjectDetailViewController alloc] initWithNibName:@"MMProjectDetailViewController" bundle:nil];
        [detailVC setThisProject:thisProject];
        [[self navigationController] pushViewController:detailVC animated:YES];
    }    
}
@end