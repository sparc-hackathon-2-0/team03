//  MMButton.h
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
#import <UIKit/UIKit.h>
@interface MMButton : UIButton {
    UIColor *ButtonBackgroundColor;
}
@property (strong, nonatomic) UIColor *ButtonBackgroundColor;
- (void)setButtonBackground;
@end