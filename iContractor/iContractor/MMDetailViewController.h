//
//  MMDetailViewController.h
//  iContractor
//
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
