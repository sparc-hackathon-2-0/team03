//  MMTimeDetailViewController.m
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
#import "MMTimeDetailViewController.h"
#import "MMButton.h"
#import "MMProject.h"
#import "MMTime.h"
@implementation MMTimeDetailViewController
@synthesize AcceptButton;
@synthesize CurrentType;
@synthesize StartTimeButton;
@synthesize StopTimeButton;
@synthesize ThisProject;
@synthesize ThisTime;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[self AcceptButton] setButtonBackgroundColor:[UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:1.0]];
    [[self AcceptButton] setButtonBackground];
    [[[self AcceptButton] titleLabel] setTextAlignment:UITextAlignmentCenter];

    [[self StartTimeButton] setButtonBackgroundColor:[UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:1.0]];
    [[self StartTimeButton] setButtonBackground];
    
    [[self StopTimeButton] setButtonBackgroundColor:[UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:1.0]];
    [[self StopTimeButton] setButtonBackground];
}
- (void)viewWillAppear:(BOOL)animated {
    if (![self ThisTime]) {
        MMTime *newTime = [[MMTime alloc] init];
        [newTime setOwningProject:[self ThisProject]];
        [[[self ThisProject] LoggedTimes] addObject:newTime];
        [self setThisTime:newTime];
    }
    
    [super viewWillAppear:animated];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    if ([[self ThisTime] StartTimeStamp]) {
        [[self StartTimeButton] setTitle:[formatter stringFromDate:[[self ThisTime] StartTimeStamp]] forState:UIControlStateNormal];
    } else {
        [[self StartTimeButton] setTitle:@"-------" forState:UIControlStateNormal];
    }
    if ([[self ThisTime] StopTimeStamp]) {
        [[self StopTimeButton]  setTitle:[formatter stringFromDate:[[self ThisTime] StopTimeStamp]] forState:UIControlStateNormal];
    } else {
        [[self StopTimeButton] setTitle:@"-------" forState:UIControlStateNormal];
    }
    if ([[[self StartTimeButton] currentTitle] isEqualToString:@"-------"] || [[[self StopTimeButton] currentTitle] isEqualToString:@"-------"]) {
        [[self AcceptButton] setUserInteractionEnabled:NO];
    } else {
        [[self AcceptButton] setUserInteractionEnabled:YES];
    }
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (IBAction)AcceptPressed:(id)sender {
    if (![self ThisTime]) {
        MMTime *newTime = [[MMTime alloc] init];
        [newTime setOwningProject:[self ThisProject]];
        [self setThisTime:newTime];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    [[self ThisTime] setStartTimeStamp: [formatter dateFromString:[[self StartTimeButton]   currentTitle]]];
    [[self ThisTime] setStopTimeStamp:  [formatter dateFromString:[[self StopTimeButton]    currentTitle]]];
    
    [[self navigationController] popViewControllerAnimated:YES];
}
- (IBAction)StartPressed:(id)sender {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    MMSelectDateTimeViewController *picker = [[MMSelectDateTimeViewController alloc] initWithNibName:@"MMSelectDateTimeViewController" bundle:nil];
    [picker setOwner:self];
    if ([[[self StartTimeButton] currentTitle] isEqualToString:@"-------"]) {
        [[picker DatePicker] setDate:[NSDate date]];
    } else {
        [[picker DatePicker] setDate:[formatter dateFromString:[[self StartTimeButton] currentTitle]]];
    }
    [self setCurrentType:kCurrentTimeTypeStart];
    [picker setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:picker animated:YES completion:NULL];
}
- (IBAction)StopPressed:(id)sender {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    MMSelectDateTimeViewController *picker = [[MMSelectDateTimeViewController alloc] initWithNibName:@"MMSelectDateTimeViewController" bundle:nil];
    [picker setOwner:self];
    if ([[[self StopTimeButton] currentTitle] isEqualToString:@"-------"]) {
        [[picker DatePicker] setDate:[NSDate date]];
    } else {
        [[picker DatePicker] setDate:[formatter dateFromString:[[self StartTimeButton] currentTitle]]];
    }
    [self setCurrentType:kCurrentTimeTypeStop];
    [picker setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:picker animated:YES completion:NULL];
}
- (void)datePickerDone:(MMSelectDateTimeViewController *)picker {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    if ([self CurrentType] == kCurrentTimeTypeStart) {
        NSDate              *dateTime = [[picker DatePicker] date];
        NSDateComponents    *seconds = [[NSCalendar currentCalendar] components: NSSecondCalendarUnit fromDate:dateTime];
        dateTime = [NSDate dateWithTimeIntervalSinceReferenceDate:[dateTime timeIntervalSinceReferenceDate] - [seconds second]];
        [[self ThisTime] setStartTimeStamp:dateTime];
        [[self StartTimeButton] setTitle:[formatter stringFromDate:[[self ThisTime] StartTimeStamp]] forState:UIControlStateNormal];
    } else {
        NSDate              *dateTime = [[picker DatePicker] date];
        NSDateComponents    *seconds = [[NSCalendar currentCalendar] components: NSSecondCalendarUnit fromDate:dateTime];
        dateTime = [NSDate dateWithTimeIntervalSinceReferenceDate:[dateTime timeIntervalSinceReferenceDate] - [seconds second]];
        [[self ThisTime] setStopTimeStamp:dateTime];
        [[self StopTimeButton] setTitle:[formatter stringFromDate:[[self ThisTime] StopTimeStamp]] forState:UIControlStateNormal];
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
    [self setCurrentType:kCurrentTimeTypeNone];
}
@end