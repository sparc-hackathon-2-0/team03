//  MMAddClientViewController.m
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
#import "MMAddClientViewController.h"
#import "MMAppDelegate.h"
#import "MMButton.h"
#import "MMClient.h"
@implementation MMAddClientViewController
@synthesize AddClient;
@synthesize ContactField;
@synthesize Delegate;
@synthesize EmailField;
@synthesize NameField;
@synthesize NumberField;
@synthesize RateField;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDelegate:(MMAppDelegate *)[[UIApplication sharedApplication] delegate]];
    
    [[self AddClient] setButtonBackgroundColor:[UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:1.0]];
    [[self AddClient] setButtonBackground];
    
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
- (IBAction)AddClientPressed:(id)sender {
    float rate;
    [[NSScanner scannerWithString:[[self RateField] text]] scanFloat:&rate];
    
    MMClient *newClient = [[MMClient alloc] init];
    [newClient setEmail:            [[self EmailField] text]];
    [newClient setHourlyRate:       [NSNumber numberWithFloat:rate]];
    [newClient setInvoices:         [NSMutableArray array]];
    [newClient setName:             [[self NameField] text]];
    [newClient setPhone:            [[self NumberField] text]];
    [newClient setPrimaryContact:   [[self ContactField] text]];
    NSMutableArray *clients = [[self Delegate] ClientList];
    [clients addObject:newClient];
    NSSortDescriptor *sortByName = [[NSSortDescriptor alloc] initWithKey:@"Name" ascending:YES];
    [clients sortUsingDescriptors:@[sortByName]];
    
    [[self navigationController] popViewControllerAnimated:YES];
}
@end
