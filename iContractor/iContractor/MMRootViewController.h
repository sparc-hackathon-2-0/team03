//
//  MMMasterViewController.h
//  iContractor
//
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMDetailViewController;

@interface MMMasterViewController : UITableViewController

@property (strong, nonatomic) MMDetailViewController *detailViewController;

@end