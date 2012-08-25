//  MMRootViewController.h
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
#import <UIKit/UIKit.h>
@class MMButton;
@class MMClientsViewController;
@class MMTimeViewController;
@interface MMRootViewController : UIViewController {
    MMButton        *ClientsButton;
    MMButton        *TimeButton;
}
@property (strong, nonatomic) IBOutlet  MMButton    *ClientsButton;
@property (strong, nonatomic) IBOutlet  MMButton    *TimeButton;
- (IBAction)ClientsPressed:(id)sender;
- (IBAction)TimePressed:(id)sender;
@end