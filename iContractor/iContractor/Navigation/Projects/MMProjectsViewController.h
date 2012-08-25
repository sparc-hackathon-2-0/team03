//  MMProjectsViewController.h
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
#import <UIKit/UIKit.h>
@interface MMProjectsViewController : UITableViewController {
    NSMutableArray  *ProjectsList;
    NSString        *ClientName;
    UITableView     *ProjectsTableView;
}
@property (strong, nonatomic)           NSMutableArray  *ProjectsList;
@property (strong, nonatomic)           NSString        *ClientName;
@property (strong, nonatomic) IBOutlet  UITableView     *ProjectsTableView;
@end