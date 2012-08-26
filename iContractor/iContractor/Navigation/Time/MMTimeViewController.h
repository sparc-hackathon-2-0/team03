//  MMTimeViewController.h
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
#import <UIKit/UIKit.h>
@class MMAppDelegate;
@interface MMTimeViewController : UITableViewController {
    MMAppDelegate *Delegate;
}
@property (strong, nonatomic) MMAppDelegate *Delegate;
@end