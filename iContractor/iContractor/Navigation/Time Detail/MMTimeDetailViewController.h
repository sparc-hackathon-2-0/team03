//  MMTimeDetailViewController.h
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
typedef enum {
    kCurrentTimeTypeNone,
    kCurrentTimeTypeStart,
    kCurrentTimeTypeStop
} MMCurrentTimeType;
#import <UIKit/UIKit.h>
#import "MMSelectDateTimeViewController.h"
@class MMButton;
@class MMProject;
@class MMTime;
@interface MMTimeDetailViewController : UIViewController <DatePickerDelegate> {
    MMButton            *AcceptButton;
    MMButton            *StartTimeButton;
    MMButton            *StopTimeButton;
    MMCurrentTimeType    CurrentType;
    MMProject           *ThisProject;
    MMTime              *ThisTime;
}
@property (strong, nonatomic) IBOutlet  MMButton            *AcceptButton;
@property (strong, nonatomic) IBOutlet  MMButton            *StartTimeButton;
@property (strong, nonatomic) IBOutlet  MMButton            *StopTimeButton;
@property (assign, nonatomic)           MMCurrentTimeType    CurrentType;
@property (strong, nonatomic)           MMProject           *ThisProject;
@property (strong, nonatomic)           MMTime              *ThisTime;
- (IBAction)AcceptPressed:(id)sender;
- (IBAction)StartPressed:(id)sender;
- (IBAction)StopPressed:(id)sender;
@end