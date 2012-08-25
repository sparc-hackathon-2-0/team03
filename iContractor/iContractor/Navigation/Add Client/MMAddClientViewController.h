//  MMAddClientViewController.h
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
#import <UIKit/UIKit.h>
@class MMAppDelegate;
@class MMButton;
@interface MMAddClientViewController : UIViewController <UITextFieldDelegate> {
    MMAppDelegate   *Delegate;
    MMButton        *AddClient;
    UITextField     *ContactField;
    UITextField     *EmailField;
    UITextField     *NameField;
    UITextField     *NumberField;
    UITextField     *RateField;
}
@property (strong, nonatomic) IBOutlet  MMAppDelegate   *Delegate;
@property (strong, nonatomic) IBOutlet  MMButton        *AddClient;
@property (strong, nonatomic) IBOutlet  UITextField     *ContactField;
@property (strong, nonatomic) IBOutlet  UITextField     *EmailField;
@property (strong, nonatomic) IBOutlet  UITextField     *NameField;
@property (strong, nonatomic) IBOutlet  UITextField     *NumberField;
@property (strong, nonatomic) IBOutlet  UITextField     *RateField;
- (IBAction)AddClientPressed:(id)sender;
@end