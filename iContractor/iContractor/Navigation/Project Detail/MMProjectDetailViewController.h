//  MMProjectDetailViewController.h
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
typedef enum {
    kMMPayRateHourly,
    kMMPayRateLumpSum
} MMPayRateType;
#import <UIKit/UIKit.h>
@class MMProject;
@interface MMProjectDetailViewController : UIViewController <UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate> {
    MMProject   *ThisProject;
    UILabel     *NameLabel;
    UILabel     *RateLabel;
    UITableView *TimesTableView;
}
@property (strong, nonatomic)           MMProject   *ThisProject;
@property (strong, nonatomic) IBOutlet  UILabel     *NameLabel;
@property (strong, nonatomic) IBOutlet  UILabel     *RateLabel;
@property (strong, nonatomic) IBOutlet  UITableView *TimesTableView;
@end