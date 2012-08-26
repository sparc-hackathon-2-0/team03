//  MMProject.m
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
#import "MMProject.h"
#import "MMClient.h"
@implementation MMProject
@synthesize HourlyRate;
@synthesize LoggedTimes;
@synthesize Name;
@synthesize OwningClient;
@synthesize ProjectLumpSum;
- (id) initForClient:(MMClient *)client {
    self = [super init];
    if (self) {
        [self setHourlyRate:[client HourlyRate]];
        [self setLoggedTimes:[NSMutableArray array]];
        [self setOwningClient:client];
    }
    return self;
}
- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        [self setHourlyRate:    [aDecoder decodeObjectForKey:@"HourlyRate"]];
        [self setLoggedTimes:   [aDecoder decodeObjectForKey:@"LoggedTimes"]];
        [self setName:          [aDecoder decodeObjectForKey:@"Name"]];
        [self setOwningClient:  [aDecoder decodeObjectForKey:@"OwningClient"]];
        [self setProjectLumpSum:[aDecoder decodeObjectForKey:@"ProjectLumpSum"]];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:[self HourlyRate]      forKey:@"HourlyRate"];
    [aCoder encodeObject:[self LoggedTimes]     forKey:@"LoggedTimes"];
    [aCoder encodeObject:[self Name]            forKey:@"Name"];
    [aCoder encodeObject:[self OwningClient]    forKey:@"OwningClient"];
    [aCoder encodeObject:[self ProjectLumpSum]  forKey:@"ProjectLumpSum"];
}
@end