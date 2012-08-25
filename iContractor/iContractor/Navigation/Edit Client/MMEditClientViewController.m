//  MMEditClientViewController.m
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
#import "MMEditClientViewController.h"
#import "MMAppDelegate.h"
#import "MMButton.h"
#import "MMClient.h"
@implementation MMEditClientViewController
@synthesize AcceptChanges;
@synthesize ContactField;
@synthesize Delegate;
@synthesize EmailField;
@synthesize NameField;
@synthesize NumberField;
@synthesize RateField;
@synthesize ThisClient;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Edit Client Info"];
    [self setDelegate:(MMAppDelegate *)[[UIApplication sharedApplication] delegate]];
    [[self NameField] becomeFirstResponder];
    [[self NameField]       setText:[[self ThisClient] Name]];
    [[self EmailField]      setText:[[self ThisClient] Email]];
    [[self ContactField]    setText:[[self ThisClient] PrimaryContact]];
    [[self RateField]       setText:[NSString stringWithFormat:@"%.02f", [[[self ThisClient] HourlyRate] floatValue]]];
    [[self NumberField]     setText:[[self ThisClient] Phone]];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - My Button Press method
- (IBAction)AcceptChangesPressed:(id)sender {
    float rate;
    [[NSScanner scannerWithString:[[self RateField] text]] scanFloat:&rate];
    
    [[self ThisClient] setEmail:            [[self EmailField] text]];
    [[self ThisClient] setHourlyRate:       [NSNumber numberWithFloat:rate]];
    [[self ThisClient] setName:             [[self NameField] text]];
    [[self ThisClient] setPhone:            [[self NumberField] text]];
    [[self ThisClient] setPrimaryContact:   [[self ContactField] text]];
    
    NSMutableArray *clients = [[self Delegate] ClientList];
    NSSortDescriptor *sortByName = [[NSSortDescriptor alloc] initWithKey:@"Name" ascending:YES];
    [clients sortUsingDescriptors:@[sortByName]];

    [[self navigationController] popViewControllerAnimated:YES];
}
#pragma mark - UITextFieldDelegate method
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == [self NumberField]) {
        int length = [self getLength:[textField text]];
        if (length == 10) {
            if (range.length == 0) {
                return NO;
            }
        }
        if(length == 3) {
            NSString *num = [self formatNumber:textField.text];
            textField.text = [NSString stringWithFormat:@"(%@) ",num];
            if(range.length > 0)
                textField.text = [NSString stringWithFormat:@"%@",[num substringToIndex:3]];
        } else if(length == 6) {
            NSString *num = [self formatNumber:textField.text];
            //NSLog(@"%@",[num  substringToIndex:3]);
            //NSLog(@"%@",[num substringFromIndex:3]);
            textField.text = [NSString stringWithFormat:@"(%@) %@-",[num  substringToIndex:3],[num substringFromIndex:3]];
            if(range.length > 0)
                textField.text = [NSString stringWithFormat:@"(%@) %@",[num substringToIndex:3],[num substringFromIndex:3]];
        }
        return YES;
    }
    return NO;
}
- (NSString *)formatNumber:(NSString *)mobileNumber {
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    NSLog(@"%@", mobileNumber);
    int length = [mobileNumber length];
    if(length > 10) {
        mobileNumber = [mobileNumber substringFromIndex: length-10];
        NSLog(@"%@", mobileNumber);
    }
    return mobileNumber;
}
-(int)getLength:(NSString*)mobileNumber {
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    int length = [mobileNumber length];
    return length;
}
@end