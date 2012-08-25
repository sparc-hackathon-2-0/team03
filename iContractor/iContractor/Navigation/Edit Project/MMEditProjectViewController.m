//  MMEditProjectViewController.m
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
#import "MMEditProjectViewController.h"
#import "MMButton.h"
#import "MMClient.h"
#import "MMProject.h"
@implementation MMEditProjectViewController
@synthesize AcceptChanges;
@synthesize NameField;
@synthesize RateField;
@synthesize RateTypeSegmentedControl;
@synthesize ThisProject;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self NameField] setText:[[self ThisProject] Name]];
    
    [[self RateField] setText:[NSString stringWithFormat:@"%.02f", [[[self ThisProject] HourlyRate] floatValue]]];
    
    [[self AcceptChanges] setButtonBackgroundColor:[UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:1.0]];
    [[self AcceptChanges] setButtonBackground];
    
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
    
    [[self ThisProject] setName:[[self NameField] text]];
    
    NSInteger selectedIndex = [[self RateTypeSegmentedControl] selectedSegmentIndex];
    NSString *selectedTitle = [[self RateTypeSegmentedControl] titleForSegmentAtIndex:selectedIndex];
    if ([selectedTitle isEqualToString:@"Hourly"]) {
        // It's an hourly rate (but it may be unset, so use the Client's default hourly rate)
        float rate = -1;
        if ([[[self RateField] text] length] > 0) {
            [[NSScanner scannerWithString:[[self RateField] text]] scanFloat:&rate];
            [[self ThisProject] setHourlyRate:[NSNumber numberWithFloat:rate]];
        } else {
            [[self ThisProject] setHourlyRate:nil];
        }
        [[self ThisProject] setProjectLumpSum:nil];
    } else {
        // It's a lump sum, so we default to zero if none entered
        float rate = 0;
        if ([[[self RateField] text] length] > 0) {
            [[NSScanner scannerWithString:[[self RateField] text]] scanFloat:&rate];
        }
        [[self ThisProject] setHourlyRate:nil];
        [[self ThisProject] setProjectLumpSum:[NSNumber numberWithFloat:rate]];
    }
    
    NSMutableArray *projects = [[[self ThisProject] OwningClient] Projects];
    NSSortDescriptor *sortByName = [[NSSortDescriptor alloc] initWithKey:@"Name" ascending:YES];
    [projects sortUsingDescriptors:@[sortByName]];
    
    [[self navigationController] popViewControllerAnimated:YES];
}
@end