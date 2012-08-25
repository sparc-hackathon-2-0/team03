//  MMAppDelegate.m
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
#import "MMAppDelegate.h"
#import "FileHelpers.h"
#import "MMRootViewController.h"
@implementation MMAppDelegate
@synthesize ClientList;
@synthesize NavigationController;
@synthesize Window;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self loadData];
    [self setWindow:[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]];
    MMRootViewController *rootVC = [[MMRootViewController alloc] initWithNibName:@"MMRootViewController" bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rootVC];
    [self setNavigationController:navController];
    [[self Window] setRootViewController:[self NavigationController]];
    [[self Window] makeKeyAndVisible];
    return YES;
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self loadData];
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self saveData];
}
- (void)loadData {
    [self setClientList:    [NSKeyedUnarchiver unarchiveObjectWithFile:[self pathToDataFile]]];
    if (![self ClientList]) {
        [self setClientList:[NSMutableArray array]];
    }
}
- (void)saveData {
    [NSKeyedArchiver archiveRootObject:[self ClientList]    toFile:[self pathToDataFile]];
}
- (NSString *)pathToDataFile {
    return pathInDocumentDirectory(@"Clients.data");
}
@end
