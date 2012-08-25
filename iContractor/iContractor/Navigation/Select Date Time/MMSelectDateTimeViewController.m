//  MMSelectDateTimeViewController.m
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
#import "MMSelectDateTimeViewController.h"
#import "MMButton.h"
@implementation MMSelectDateTimeViewController
@synthesize AcceptTimeStamp;
@synthesize DatePicker;
@synthesize Owner;
- (void) viewDidLoad {
    [super viewDidLoad];
    [[self AcceptTimeStamp] setButtonBackgroundColor:[UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:1.0]];
    [[self AcceptTimeStamp] setButtonBackground];
}
- (IBAction)AcceptPressed:(id)sender {
    [[self Owner] datePickerDone:self];
}
@end