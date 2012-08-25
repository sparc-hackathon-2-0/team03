//  MMProject.h
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
#import <Foundation/Foundation.h>
@class MMClient;
@interface MMProject : NSObject <NSCoding> {
    __weak  MMClient        *OwningClient;
            NSMutableArray  *LoggedTimes;
            NSNumber        *HourlyRate;
            NSNumber        *ProjectLumpSum;
            NSString        *Name;
}
@property (weak,   nonatomic) MMClient          *OwningClient;
@property (strong, nonatomic) NSMutableArray    *LoggedTimes;
@property (strong, nonatomic) NSNumber          *HourlyRate;
@property (strong, nonatomic) NSNumber          *ProjectLumpSum;
@property (strong, nonatomic) NSString          *Name;
- (id) initForClient:(MMClient *)client;
@end