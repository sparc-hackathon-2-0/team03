//  MMInvoice.m
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
#import "MMInvoice.h"
#import "MMClient.h"
#import "MMProject.h"
#import "MMTime.h"
@implementation MMInvoice
+ (NSString *)htmlForInvoiceForClient:(MMClient *)client {
    NSMutableString *html = [[NSMutableString alloc] init];
    // An NSDateFormatter for general use
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    // Make the PDF's html
    [html appendString:@"<html>"];
    [html appendString:@"<body>"];
    [html appendFormat:@"<h1>Dear %@,</h1><br />\n", [client Name]];
    [html appendString:@"<p>Please see the most recent charges below.</p><br />\n"];
    float totalCharge = 0;
    for (MMProject *project in [client Projects]) {
        float projectCharge = 0;
        if ([project ProjectLumpSum]) {
            totalCharge = totalCharge + [[project ProjectLumpSum] floatValue];
            projectCharge = [[project ProjectLumpSum] floatValue];
        }
        [html appendFormat:@"<h2>%@</h2>", [project Name]];
        for (MMTime *time in [project LoggedTimes]) {
            [html appendFormat:@"<h3>Start Time: %@</h3><br />\n", [formatter stringFromDate:[time StartTimeStamp]]];
            [html appendFormat:@"<h3>Stop Time: %@</h3><br />\n", [formatter stringFromDate:[time StopTimeStamp]]];
            [html appendFormat:@"<h3>Total Hours: %@</h3><br />\n", [time TimeString]];
            if ([project HourlyRate]) {
                totalCharge = [[time TotalHours] floatValue] * [[project HourlyRate] floatValue];
                projectCharge = projectCharge + [[time TotalHours] floatValue] * [[project HourlyRate] floatValue];
                float timeCharge = [[time TotalHours] floatValue] * [[project HourlyRate] floatValue];
                [html appendFormat:@"<h3>Charge: $%.02f</h3><br />\n", timeCharge];
            }
            [html appendString:@"<br />\n"];
        }
        [html appendFormat:@"<h2>Project Charge: $%.02f</h2><br />\n", projectCharge];
    }
    [html appendFormat:@"<h1>Total Charge: $%.02f</h1><br />\n", totalCharge];
    [html appendString:@"<p>Payment is due within 14 days of receipt of invoice. Thank you.</p>"];
    [html appendString:@"</body>"];
    [html appendString:@"</html>"];
    NSLog(@"\n%@", [html stringByReplacingOccurrencesOfString:@"><" withString:@">\n<"]);
    return html;
}
@end