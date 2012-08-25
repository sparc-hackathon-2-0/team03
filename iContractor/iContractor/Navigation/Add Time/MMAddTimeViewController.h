//  MMAddTimeViewController.h
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
#import <UIKit/UIKit.h>
@class MMButton;
@class MMProject;
@interface MMAddTimeViewController : UIViewController {
    MMButton        *StartStopButton;
    MMProject       *ThisProject;
    NSDate          *LastStarted;
    NSTimeInterval   ElapsedTime;
    NSTimer         *Timer;
    UILabel         *ElapsedTimeLabel;
}
@property (strong, nonatomic) IBOutlet  MMButton        *StartStopButton;
@property (strong, nonatomic)           MMProject       *ThisProject;
@property (strong, nonatomic)           NSDate          *LastStarted;
@property (assign, nonatomic)           NSTimeInterval   ElapsedTime;
@property (strong, nonatomic)           NSTimer         *Timer;
@property (strong, nonatomic) IBOutlet  UILabel         *ElapsedTimeLabel;
- (IBAction)StartStopPressed:(id)sender;
@end