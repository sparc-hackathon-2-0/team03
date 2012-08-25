//  MMRootViewController.m
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
#import "MMRootViewController.h"
#import "MMButton.h"
#import "MMClientsViewController.h"
#import "MMTimeViewController.h"
@implementation MMRootViewController
@synthesize ClientsButton;
@synthesize TimeButton;
- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    [[self ClientsButton]   setButtonBackgroundColor:[UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:1.0]];
    [[self ClientsButton]   setButtonBackground];
    [[self TimeButton]      setButtonBackgroundColor:[UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:1.0]];
    [[self TimeButton]      setButtonBackground];
    [[[self TimeButton] titleLabel] setTextAlignment:UITextAlignmentCenter];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (![[self navigationController] isNavigationBarHidden]) {
        [[self navigationController] setNavigationBarHidden:YES animated:YES];
    }
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return  (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (IBAction)ClientsPressed:(id)sender {
    MMClientsViewController *vc = [[MMClientsViewController alloc] initWithNibName:@"MMClientsViewController" bundle:nil];
    [[self navigationController] pushViewController:vc animated:YES];
}
- (IBAction)TimePressed:(id)sender {
    MMTimeViewController *vc = [[MMTimeViewController alloc] initWithNibName:@"MMTimeViewController" bundle:nil];
    [[self navigationController] pushViewController:vc animated:YES];
}
@end