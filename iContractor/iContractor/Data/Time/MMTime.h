//  MMTime.h
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
#import <Foundation/Foundation.h>
@class MMProject;
@interface MMTime : NSObject <NSCoding> {
    BOOL                 Invoiced;
    __weak MMProject    *OwningProject;
    NSDate              *StartTimeStamp;
    NSDate              *StopTimeStamp;
    NSNumber            *TotalHours;
}
@property (assign, nonatomic) BOOL       Invoiced;
@property (weak,   nonatomic) MMProject *OwningProject;
@property (strong, nonatomic) NSDate    *StartTimeStamp;
@property (strong, nonatomic) NSDate    *StopTimeStamp;
@property (strong, nonatomic) NSNumber  *TotalHours;
- (NSString *)TimeString;
@end