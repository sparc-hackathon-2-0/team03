//  MMAddTimeViewController.m
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
#import "MMAddTimeViewController.h"
#import "MMButton.h"
#import "MMClient.h"
#import "MMProject.h"
#import "MMTime.h"
@implementation MMAddTimeViewController
@synthesize ElapsedTime;
@synthesize ElapsedTimeLabel;
@synthesize LastStarted;
@synthesize StartStopButton;
@synthesize ThisProject;
@synthesize Timer;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setElapsedTime:0];
    [self setTimer:nil];
    
    [[self StartStopButton] setButtonBackgroundColor:[UIColor colorWithRed:0.00 green:0.75 blue:0.00 alpha:1.00]];
    [[self StartStopButton] setButtonBackground];
    
}
- (void)viewWillAppear:(BOOL)animated {
    MMClient *client = [[self ThisProject] OwningClient];
    [self setTitle:[client Name]];
}
- (void)viewWillDisappear:(BOOL)animated {
    if ([self Timer]) {
        NSDate *stopped = [NSDate date];
        NSDate *started = [self LastStarted];
        MMTime *newTime = [[MMTime alloc] init];
        [newTime setStartTimeStamp:started];
        [newTime setStopTimeStamp:stopped];
        [newTime setOwningProject:[self ThisProject]];
        [[[self ThisProject] LoggedTimes] addObject:newTime];
    }
}
- (IBAction)StartStopPressed:(id)sender {
    if (![self Timer]) {
        [self setTimer:[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES]];
        [self setLastStarted:[NSDate date]];
        [[self StartStopButton] setTitle:@"Stop Timer" forState:UIControlStateNormal];
        [[self StartStopButton] setButtonBackgroundColor:[UIColor colorWithRed:0.75 green:0.00 blue:0.00 alpha:1.00]];
        [[self StartStopButton] setButtonBackground];
    } else {
        NSDate *stopped = [NSDate date];
        NSDate *started = [self LastStarted];
        MMTime *newTime = [[MMTime alloc] init];
        [newTime setStartTimeStamp:started];
        [newTime setStopTimeStamp:stopped];
        [newTime setOwningProject:[self ThisProject]];
        [[[self ThisProject] LoggedTimes] addObject:newTime];
        NSTimeInterval elapsed = [stopped timeIntervalSinceDate:started];
        [self setElapsedTime:[self ElapsedTime] + elapsed];
        [[self Timer] invalidate];
        [self setTimer:nil];
        [self setLastStarted:nil];
        [[self StartStopButton] setTitle:@"Start Timer" forState:UIControlStateNormal];
        [[self StartStopButton] setButtonBackgroundColor:[UIColor colorWithRed:0.00 green:0.75 blue:0.00 alpha:1.00]];
        [[self StartStopButton] setButtonBackground];
    }
}
- (void)timerFired {
    NSTimeInterval seconds = [[NSDate date] timeIntervalSinceDate:[self LastStarted]];
    seconds = seconds + [self ElapsedTime];
    int   hrs       = (int)floorf(seconds / 3600.0);
    seconds         = seconds - (hrs * 3600.0);
    int   min       = (int)floorf(seconds / 60.0);
    seconds         = seconds - (min * 60.0);
    int   sec       = (int)floorf(seconds);
    [[self ElapsedTimeLabel] setText:[NSString stringWithFormat:@"%02d:%02d:%02d", hrs, min, sec]];
}
@end