//  MMEditProjectViewController.h
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
#import <UIKit/UIKit.h>
@class MMButton;
@class MMProject;
@interface MMEditProjectViewController : UIViewController <UITextFieldDelegate> {
    MMButton            *AcceptChanges;
    MMProject           *ThisProject;
    UISegmentedControl  *RateTypeSegmentedControl;
    UITextField         *NameField;
    UITextField         *RateField;
}
@property (strong, nonatomic) IBOutlet  MMButton            *AcceptChanges;
@property (strong, nonatomic)           MMProject           *ThisProject;
@property (strong, nonatomic) IBOutlet  UISegmentedControl  *RateTypeSegmentedControl;
@property (strong, nonatomic) IBOutlet  UITextField         *NameField;
@property (strong, nonatomic) IBOutlet  UITextField         *RateField;
- (IBAction)AddProjectPressed:(id)sender;
@end