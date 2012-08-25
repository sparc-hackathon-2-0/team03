//  FileHelpers.m
//  iContractor
//  Created by Michael McEvoy on 8/25/12
//  Copyright 2012 Michael McEvoy. All rights reserved.
#include "FileHelpers.h"
NSString *pathInDocumentDirectory(NSString *fileName) {
	NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDirectory = [documentDirectories objectAtIndex:0];
	return [documentDirectory stringByAppendingPathComponent:fileName];
}