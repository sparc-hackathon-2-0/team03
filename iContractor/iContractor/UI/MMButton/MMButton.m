//  MMButton.m
//  iContractor
//  Created by Michael McEvoy on 8/25/12.
//  Copyright (c) 2012 Michael McEvoy. All rights reserved.
#import "MMButton.h"
#import "UIImage+MMButton.h"
@implementation MMButton
@synthesize ButtonBackgroundColor;
- (void)awakeFromNib {
    [self setButtonBackground];
}
- (void)setButtonBackground {
    CGRect rect = [self bounds];
    UIColor *buttonColor = [self ButtonBackgroundColor];
    UIImage *background = [UIImage imageForSize:[self frame].size opaque:NO withDrawingBlock:^{
        //// General Declarations
        CGColorSpaceRef colorSpace  = CGColorSpaceCreateDeviceRGB();
        CGContextRef    context     = UIGraphicsGetCurrentContext();
        
        //// Color Declarations
        UIColor *frameColorTop      = [UIColor colorWithRed: 0.2 green: 0.2 blue: 0.2 alpha: 1];
        UIColor *frameShadowColor   = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 0.4];
        CGFloat buttonColorRGBA[4];
        [buttonColor getRed: &buttonColorRGBA[0] green: &buttonColorRGBA[1] blue: &buttonColorRGBA[2] alpha: &buttonColorRGBA[3]];
        
//        UIColor* glossyColorBottom = [UIColor colorWithRed: (buttonColorRGBA[0] * 0.6 + 0.4) green: (buttonColorRGBA[1] * 0.6 + 0.4) blue: (buttonColorRGBA[2] * 0.6 + 0.4) alpha: 1.0];
//        UIColor* glossyColorUp = [UIColor colorWithRed: (buttonColorRGBA[0] * 0.2 + 0.8) green: (buttonColorRGBA[1] * 0.2 + 0.8) blue: (buttonColorRGBA[2] * 0.2 + 0.8) alpha: 0.5];
//        
//        //// Gradient Declarations
//        NSArray* glossyGradientColors = [NSArray arrayWithObjects:
//                                         (id)glossyColorUp.CGColor,
//                                         (id)glossyColorBottom.CGColor, nil];
//        CGFloat glossyGradientLocations[] = {0, 1};
//        CGGradientRef glossyGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)glossyGradientColors, glossyGradientLocations);
        
        //// Shadow Declarations
        UIColor* frameInnerShadow = frameShadowColor;
        CGSize frameInnerShadowOffset = CGSizeMake(0, -0);
        CGFloat frameInnerShadowBlurRadius = 3;
        UIColor* buttonInnerShadow = [UIColor blackColor];
        CGSize buttonInnerShadowOffset = CGSizeMake(0, -0);
        CGFloat buttonInnerShadowBlurRadius = 12;
        UIColor* buttonShadow = [UIColor blackColor];
        CGSize buttonShadowOffset = CGSizeMake(0, 2);
        CGFloat buttonShadowBlurRadius = 3;
        
        //// outerFrame Drawing
        UIBezierPath* outerFramePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(2, 2, rect.size.width - 4, rect.size.height - 4) cornerRadius: 8];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, buttonShadowOffset, buttonShadowBlurRadius, buttonShadow.CGColor);
        [frameColorTop setFill];
        [outerFramePath fill];
        CGContextRestoreGState(context);
        
        [[UIColor blackColor] setStroke];
        outerFramePath.lineWidth = 1;
        [outerFramePath stroke];
        
        
        //// innerFrame Drawing
        UIBezierPath* innerFramePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(5, 5, rect.size.width - 10, rect.size.height - 10) cornerRadius: 5];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, frameInnerShadowOffset, frameInnerShadowBlurRadius, frameInnerShadow.CGColor);
        [buttonColor setFill];
        [innerFramePath fill];
        
        ////// innerFrame Inner Shadow
        CGRect innerFrameBorderRect = CGRectInset([innerFramePath bounds], -buttonInnerShadowBlurRadius, -buttonInnerShadowBlurRadius);
        innerFrameBorderRect = CGRectOffset(innerFrameBorderRect, -buttonInnerShadowOffset.width, -buttonInnerShadowOffset.height);
        innerFrameBorderRect = CGRectInset(CGRectUnion(innerFrameBorderRect, [innerFramePath bounds]), -1, -1);
        
        UIBezierPath* innerFrameNegativePath = [UIBezierPath bezierPathWithRect: innerFrameBorderRect];
        [innerFrameNegativePath appendPath: innerFramePath];
        innerFrameNegativePath.usesEvenOddFillRule = YES;
        
        CGContextSaveGState(context);
        {
            CGFloat xOffset = buttonInnerShadowOffset.width + round(innerFrameBorderRect.size.width);
            CGFloat yOffset = buttonInnerShadowOffset.height;
            CGContextSetShadowWithColor(context,
                                        CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                        buttonInnerShadowBlurRadius,
                                        buttonInnerShadow.CGColor);
            
            [innerFramePath addClip];
            CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(innerFrameBorderRect.size.width), 0);
            [innerFrameNegativePath applyTransform: transform];
            [[UIColor grayColor] setFill];
            [innerFrameNegativePath fill];
        }
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
        
        [[UIColor blackColor] setStroke];
        innerFramePath.lineWidth = 1;
        [innerFramePath stroke];
        
        
//        //// Rounded Rectangle Drawing
//        UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(9, 6, rect.size.width - 16, 9) cornerRadius: 4];
//        CGContextSaveGState(context);
//        [roundedRectanglePath addClip];
//        CGContextDrawLinearGradient(context, glossyGradient, CGPointMake((rect.size.width - 9) / 2.0, 6), CGPointMake((rect.size.width - 9) / 2.0, 15), 0);
//        CGContextRestoreGState(context);
        
        
        //// Cleanup
//        CGGradientRelease(glossyGradient);
        CGColorSpaceRelease(colorSpace);
    }];
    [self setBackgroundImage:background forState:UIControlStateNormal];
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    [self setButtonBackground];
}
@end