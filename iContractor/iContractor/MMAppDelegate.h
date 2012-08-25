//  MMAppDelegate.h
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
#import <UIKit/UIKit.h>
@interface MMAppDelegate : UIResponder <UIApplicationDelegate> {
    NSMutableArray          *ClientList;
    UINavigationController  *NavigationController;
    UIWindow                *Window;
}
@property (strong, nonatomic) NSMutableArray            *ClientList;
@property (strong, nonatomic) UIWindow                  *Window;
@property (strong, nonatomic) UINavigationController    *NavigationController;
@end