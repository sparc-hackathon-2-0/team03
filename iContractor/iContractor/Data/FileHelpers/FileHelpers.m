/*
 *  FileHelpers.m
 *  Homepwner
 *
 *  Created by Michael Mcevoy on 2/3/10.
 *  Copyright 2010 Image Management Solutions. All rights reserved.
 *
 */

#include "FileHelpers.h"

NSString *pathInDocumentDirectory(NSString *fileName)
{
	// Get list of document directories in sandbox
	NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	// Get one and only one document directory from that list
	NSString *documentDirectory = [documentDirectories objectAtIndex:0];
	
	// Append passed in file name to that directory, return it
	return [documentDirectory stringByAppendingPathComponent:fileName];
	
} // pathInDocumentDirectory