//  MMInvoice.h
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
#import <Foundation/Foundation.h>
@class MMClient;
@interface MMInvoice : NSObject
+ (NSString *)htmlForInvoiceForClient:(MMClient *)client;
@end