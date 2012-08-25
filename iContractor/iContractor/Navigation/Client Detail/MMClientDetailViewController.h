//  MMClientDetailViewController.h
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
@class MMButton;
@class MMClient;
@interface MMClientDetailViewController : UIViewController <MFMailComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate> {
    MFMailComposeViewController *Invoicer;
    MMButton                    *EmailClient;
    MMButton                    *CallClient;
    MMButton                    *SendInvoice;
    MMClient                    *ThisClient;
    UILabel                     *ContactLabel;
    UILabel                     *EmailLabel;
    UILabel                     *NumberLabel;
    UILabel                     *RateLabel;
    UITableView                 *ProjectsTableView;
}
@property (strong, nonatomic)           MFMailComposeViewController *Invoicer;
@property (strong, nonatomic) IBOutlet  MMButton                    *EmailClient;
@property (strong, nonatomic) IBOutlet  MMButton                    *CallClient;
@property (strong, nonatomic) IBOutlet  MMButton                    *SendInvoice;
@property (strong, nonatomic)           MMClient                    *ThisClient;
@property (strong, nonatomic) IBOutlet  UILabel                     *ContactLabel;
@property (strong, nonatomic) IBOutlet  UILabel                     *EmailLabel;
@property (strong, nonatomic) IBOutlet  UILabel                     *NumberLabel;
@property (strong, nonatomic) IBOutlet  UILabel                     *RateLabel;
@property (strong, nonatomic) IBOutlet  UITableView                 *ProjectsTableView;
- (IBAction)CallPressed:(id)sender;
- (IBAction)EmailPressed:(id)sender;
- (IBAction)InvoicePressed:(id)sender;
@end