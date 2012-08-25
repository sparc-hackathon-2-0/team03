//  MMAddProjectViewController.m
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
#import "MMAddProjectViewController.h"
#import "MMAppDelegate.h"
#import "MMButton.h"
#import "MMClient.h"
#import "MMProject.h"
@implementation MMAddProjectViewController
@synthesize AddProject;
@synthesize NameField;
@synthesize RateField;
@synthesize RateTypeSegmentedControl;
@synthesize ThisClient;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self RateField] setText:[NSString stringWithFormat:@"%.02f", [[[self ThisClient] HourlyRate] floatValue]]];
    
    [[self AddProject] setButtonBackgroundColor:[UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:1.0]];
    [[self AddProject] setButtonBackground];
    
    [[self NameField] becomeFirstResponder];
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - UITextFieldDelegate method
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - My Button Press method
- (IBAction)AddProjectPressed:(id)sender {

    MMProject *newProject = [[MMProject alloc] initForClient:[self ThisClient]];
    
    [newProject setName:[[self NameField] text]];
    
    NSInteger selectedIndex = [[self RateTypeSegmentedControl] selectedSegmentIndex];
    NSString *selectedTitle = [[self RateTypeSegmentedControl] titleForSegmentAtIndex:selectedIndex];
    if ([selectedTitle isEqualToString:@"Hourly"]) {
        // It's an hourly rate (but it may be unset, so use the Client's default hourly rate)
        float rate = -1;
        if ([[[self RateField] text] length] > 0) {
            [[NSScanner scannerWithString:[[self RateField] text]] scanFloat:&rate];
            [newProject setHourlyRate:[NSNumber numberWithFloat:rate]];
        } else {
            [newProject setHourlyRate:nil];
        }
        [newProject setProjectLumpSum:nil];
    } else {
        // It's a lump sum, so we default to zero if none entered
        float rate = 0;
        if ([[[self RateField] text] length] > 0) {
            [[NSScanner scannerWithString:[[self RateField] text]] scanFloat:&rate];
        }
        [newProject setHourlyRate:nil];
        [newProject setProjectLumpSum:[NSNumber numberWithFloat:rate]];
    }
    
    NSMutableArray *projects = [[self ThisClient] Projects];
    [projects addObject:newProject];
    NSSortDescriptor *sortByName = [[NSSortDescriptor alloc] initWithKey:@"Name" ascending:YES];
    [projects sortUsingDescriptors:@[sortByName]];
    
    [[self navigationController] popViewControllerAnimated:YES];
}
@end