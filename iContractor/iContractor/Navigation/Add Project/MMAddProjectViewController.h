//  MMAddProjectViewController.h
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
#import <UIKit/UIKit.h>
@class MMAppDelegate;
@class MMButton;
@class MMClient;
@interface MMAddProjectViewController : UIViewController <UITextFieldDelegate> {
    MMButton            *AddProject;
    __weak  MMClient    *ThisClient;;
    UISegmentedControl  *RateTypeSegmentedControl;
    UITextField         *NameField;
    UITextField         *RateField;
}
@property (strong, nonatomic) IBOutlet  MMButton            *AddProject;
@property (weak,   nonatomic)           MMClient            *ThisClient;
@property (strong, nonatomic) IBOutlet  UISegmentedControl  *RateTypeSegmentedControl;
@property (strong, nonatomic) IBOutlet  UITextField         *NameField;
@property (strong, nonatomic) IBOutlet  UITextField         *RateField;
- (IBAction)AddProjectPressed:(id)sender;
@end