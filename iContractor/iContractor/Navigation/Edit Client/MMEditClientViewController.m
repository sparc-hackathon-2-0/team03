//  MMEditClientViewController.m
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
#import "MMEditClientViewController.h"
#import "MMAppDelegate.h"
#import "MMButton.h"
#import "MMClient.h"
@implementation MMEditClientViewController
@synthesize AcceptChanges;
@synthesize ContactField;
@synthesize Delegate;
@synthesize EmailField;
@synthesize NameField;
@synthesize NumberField;
@synthesize RateField;
@synthesize ThisClient;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Edit Client Info"];
    [self setDelegate:(MMAppDelegate *)[[UIApplication sharedApplication] delegate]];
    [[self NameField] becomeFirstResponder];
    [[self NameField]       setText:[[self ThisClient] Name]];
    [[self EmailField]      setText:[[self ThisClient] Email]];
    [[self ContactField]    setText:[[self ThisClient] PrimaryContact]];
    [[self RateField]       setText:[NSString stringWithFormat:@"%.02f", [[[self ThisClient] HourlyRate] floatValue]]];
    [[self NumberField]     setText:[[self ThisClient] Phone]];
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
- (IBAction)AcceptChangesPressed:(id)sender {
    float rate;
    [[NSScanner scannerWithString:[[self RateField] text]] scanFloat:&rate];
    
    [[self ThisClient] setEmail:            [[self EmailField] text]];
    [[self ThisClient] setHourlyRate:       [NSNumber numberWithFloat:rate]];
    [[self ThisClient] setName:             [[self NameField] text]];
    [[self ThisClient] setPhone:            [[self NumberField] text]];
    [[self ThisClient] setPrimaryContact:   [[self ContactField] text]];
    
    NSMutableArray *clients = [[self Delegate] ClientList];
    NSSortDescriptor *sortByName = [[NSSortDescriptor alloc] initWithKey:@"Name" ascending:YES];
    [clients sortUsingDescriptors:@[sortByName]];

    [[self navigationController] popViewControllerAnimated:YES];
}
@end