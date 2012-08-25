//  MMTime.m
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
#import "MMTime.h"
#import "MMProject.h"
@implementation MMTime
@synthesize Invoiced;
@synthesize OwningProject;
@synthesize StartTimeStamp;
@synthesize StopTimeStamp;
@synthesize TotalHours;
- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        [self setInvoiced:      [aDecoder decodeBoolForKey:@"Invoiced"]];
        [self setOwningProject: [aDecoder decodeObjectForKey:@"OwningProject"]];
        [self setStartTimeStamp:[aDecoder decodeObjectForKey:@"StartTimeStamp"]];
        [self setStopTimeStamp: [aDecoder decodeObjectForKey:@"StopTimeStamp"]];
        [self setTotalHours:    [aDecoder decodeObjectForKey:@"TotalHours"]];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeBool:  [self Invoiced]        forKey:@"Invoiced"];
    [aCoder encodeObject:[self OwningProject]   forKey:@"OwningProject"];
    [aCoder encodeObject:[self StartTimeStamp]  forKey:@"StartTimeStamp"];
    [aCoder encodeObject:[self StopTimeStamp]   forKey:@"StopTimeStamp"];
    [aCoder encodeObject:[self TotalHours]      forKey:@"TotalHours"];
}
- (NSNumber *)TotalHours {
    float seconds = [[self StopTimeStamp] timeIntervalSinceDate:[self StartTimeStamp]];
    float hours   = seconds / 3600.0;
    return [NSNumber numberWithFloat:hours];
}
- (NSString *)TimeString {
    float seconds   = [[self StopTimeStamp] timeIntervalSinceDate:[self StartTimeStamp]];
    int   hrs       = (int)floorf(seconds / 3600.0);
    seconds         = seconds - (hrs * 3600.0);
    int   min       = (int)floorf(seconds / 60.0);
    seconds         = seconds - (min * 60.0);
    int   sec       = (int)floorf(seconds);
    return [NSString stringWithFormat:@"%02d:%02d:%02d", hrs, min, sec];
}
@end