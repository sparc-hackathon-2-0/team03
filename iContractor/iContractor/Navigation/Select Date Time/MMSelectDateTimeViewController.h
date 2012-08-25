//  MMSelectDateTimeViewController.h
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
#import <UIKit/UIKit.h>
@protocol DatePickerDelegate <NSObject>
- (void)datePickerDone:(id)picker;
@end
@class MMButton;
@interface MMSelectDateTimeViewController : UIViewController {
    __weak id<DatePickerDelegate>   Owner;
    MMButton                        *AcceptTimeStamp;
    UIDatePicker                    *DatePicker;
}
@property (weak,   nonatomic)           id<DatePickerDelegate>   Owner;
@property (strong, nonatomic) IBOutlet  MMButton                *AcceptTimeStamp;
@property (strong, nonatomic )IBOutlet  UIDatePicker            *DatePicker;
- (IBAction)AcceptPressed:(id)sender;
@end