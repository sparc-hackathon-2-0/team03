//  MMClient.h
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
#import <Foundation/Foundation.h>
@interface MMClient : NSObject <NSCoding> {
    NSMutableArray  *Invoices;
    NSMutableArray  *Projects;
    NSNumber        *HourlyRate;
    NSString        *Email;
    NSString        *Name;
    NSString        *Phone;
    NSString        *PrimaryContact;
}
@property (strong, nonatomic) NSMutableArray    *Invoices;
@property (strong, nonatomic) NSMutableArray    *Projects;
@property (strong, nonatomic) NSNumber          *HourlyRate;
@property (strong, nonatomic) NSString          *Email;
@property (strong, nonatomic) NSString          *Name;
@property (strong, nonatomic) NSString          *Phone;
@property (strong, nonatomic) NSString          *PrimaryContact;
@end