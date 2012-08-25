//  MMClient.m
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
#import "MMClient.h"
@implementation MMClient
@synthesize Email;
@synthesize HourlyRate;
@synthesize Invoices;
@synthesize Name;
@synthesize Phone;
@synthesize PrimaryContact;
@synthesize Projects;
- (id) init {
    self = [super init];
    if (self) {
        [self setInvoices:  [NSMutableArray array]];
        [self setProjects:  [NSMutableArray array]];
    }
    return self;
}
- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        [self setEmail:         [aDecoder decodeObjectForKey:@"Email"]];
        [self setHourlyRate:    [aDecoder decodeObjectForKey:@"HourlyRate"]];
        [self setInvoices:      [aDecoder decodeObjectForKey:@"Invoices"]];
        [self setName:          [aDecoder decodeObjectForKey:@"Name"]];
        [self setPhone:         [aDecoder decodeObjectForKey:@"Phone"]];
        [self setPrimaryContact:[aDecoder decodeObjectForKey:@"PrimaryContact"]];
        [self setProjects:      [aDecoder decodeObjectForKey:@"Projects"]];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:[self Email]           forKey:@"Email"];
    [aCoder encodeObject:[self HourlyRate]      forKey:@"HourlyRate"];
    [aCoder encodeObject:[self Invoices]        forKey:@"Invoices"];
    [aCoder encodeObject:[self Name]            forKey:@"Name"];
    [aCoder encodeObject:[self Phone]           forKey:@"Phone"];
    [aCoder encodeObject:[self PrimaryContact]  forKey:@"PrimaryContact"];
    [aCoder encodeObject:[self Projects]        forKey:@"Projects"];
}
@end