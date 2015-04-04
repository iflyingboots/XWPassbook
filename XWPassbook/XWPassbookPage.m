//
//  XWPassbookPage.m
//  XWPassbook
//
//  Created by sutar on 4/2/15.
//  Copyright (c) 2015 Xin Wang. All rights reserved.
//

#import "XWPassbookPage.h"
#import "XWPassbookDraw.h"
#import "XWPassbook.h"

const CGFloat kMarginTop = 30.f;
const CGFloat kPaddingBottom = 150.f;
const CGFloat kMarginBoundary = 50.f;
const CGFloat kAnimationDuration = .5f;
const CGFloat kMarginCollapsed = 40.f;

@interface XWPassbookPage ()
@end

@implementation XWPassbookPage


- (instancetype)init
{
    return [self initWithFrame:[UIScreen mainScreen].bounds];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

#pragma mark - Setter
- (void)setState:(XWPassbookPageState)state
{
    switch (state) {
        case XWPassbookPageStatePresent:
            [self present];
            break;
        case XWPassbookPageStateNormal:
            [self restore];
            break;
        case XWPassbookPageStateCollapsed:
            [self collapse];
            break;
        default:
            break;
    }
    _state = state;
}

#pragma mark - Draw

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // path
    CGContextSaveGState(context);
    CGMutablePathRef arcPath = createTicketPath(rect);
    CGContextAddPath(context, arcPath);
    CGContextSetFillColorWithColor(context, self.pageBackgroundColor.CGColor);
    CGContextFillPath(context);
    CGContextRestoreGState(context);
    
    // gloss
    CGRect glossRect = rect;
    CGMutablePathRef arcPathGloss = createTicketPath(glossRect);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    UIColor * glossFrom = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.35];
    UIColor * glossTo = [UIColor clearColor];
    NSArray *colors = @[(id)glossFrom.CGColor, (id)glossTo.CGColor];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    CGPoint gradientEnd = CGPointMake(CGRectGetMinX(glossRect), CGRectGetMaxX(glossRect));
    
    // gloss gradient
    CGContextSaveGState(context);
    CGContextAddPath(context, arcPathGloss);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, glossRect.origin, gradientEnd, 0);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    CGContextRestoreGState(context);
    
    // shadow
    UIColor * shadowColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1];
    CGContextSaveGState(context);
    CGContextAddRect(context, rect);
    CGContextAddPath(context, arcPath);
    CGContextEOClip(context);
    // clip, clip and clip
    CGContextAddPath(context, arcPath);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 2), 5.f, shadowColor.CGColor);
    CGContextFillPath(context);
    
    CGContextRestoreGState(context);
    
    CFRelease(arcPath);
    CFRelease(arcPathGloss);
}

#pragma mark - Action
- (void)present
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kXWPassbookNotificationCollapseOthers object:self];
    
    [UIView animateWithDuration:kAnimationDuration delay:0 usingSpringWithDamping:.6f initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame = ({
            CGRect frame = self.frame;
            frame.origin.y = kMarginTop;
            frame;
        });
    } completion:^(BOOL finished) {
    }];

}

- (void)restore
{
    [UIView animateWithDuration:kAnimationDuration delay:0 usingSpringWithDamping:.6f initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame = self.originalFrame;
    } completion:^(BOOL finished) {
    }];
}

- (void)collapse
{
    CGFloat bottomY = self.frame.size.height - kPaddingBottom;
    CGRect frame = self.frame;
    frame.origin.y = bottomY + self.index * kMarginCollapsed;
    [UIView animateWithDuration:kAnimationDuration delay:kAnimationDuration options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame = frame;
    } completion:^(BOOL finished) {
    }];
}

- (void)handleSingleTap
{
    if (self.state == XWPassbookPageStatePresent) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kXWPassbookNotificationRestoreAll object:self];
        self.state = XWPassbookPageStateNormal;
    } else {
        self.state = XWPassbookPageStatePresent;
    }
}

#pragma mark - Touch event

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    NSInteger tapCount = touch.tapCount;
    switch (tapCount) {
        case 0: {
            // an simple way to mimic inertia
            CGPoint location = [touch locationInView:self];
            CGPoint previousLocation = [touch previousLocationInView:self];
            CGFloat newLocationY = location.y - previousLocation.y;
            newLocationY = newLocationY > 0 ? newLocationY + 20 : newLocationY - 20;
            CGRect newFrame = CGRectOffset(self.frame, 0, newLocationY);
            
            [UIView animateWithDuration:.2f delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.frame = newFrame;
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
        case 1:
            [self handleSingleTap];
            break;
            
        default:
            break;
    }

}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    CGPoint previousLocation = [touch previousLocationInView:self];
    CGFloat newLocationY = location.y - previousLocation.y;
    CGRect newFrame = CGRectOffset(self.frame, 0, newLocationY);

    // ensure the view is not out of boundary
    if (newFrame.origin.y > self.frame.size.height - kMarginBoundary) {
        newFrame.origin.y = self.frame.size.height - kMarginBoundary;
    } else if (newFrame.origin.y < kMarginBoundary - self.frame.size.height) {
        newFrame.origin.y = kMarginBoundary - self.frame.size.height;
    }

    self.frame = newFrame;
}

@end
