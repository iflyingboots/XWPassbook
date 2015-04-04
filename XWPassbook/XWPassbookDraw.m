//
//  XWPassbookDraw.m
//  XWPassbook
//
//  Created by sutar on 4/2/15.
//  Copyright (c) 2015 Xin Wang. All rights reserved.
//

#import "XWPassbookDraw.h"

@implementation XWPassbookDraw

CGMutablePathRef createTicketPath(CGRect rect)
{
    
    CGFloat margin = 10;
    rect = CGRectInset(rect, margin, margin);
    
    CGFloat arcRadius = rect.size.width / 15;
    CGPoint arcStartPoint = CGPointMake(rect.origin.x + rect.size.width / 2  - arcRadius, rect.origin.y);
    CGPoint arcCenterPoint = CGPointMake(rect.origin.x + rect.size.width / 2, rect.origin.y );
    CGPoint arcEndPoint = CGPointMake(rect.origin.x + rect.size.width / 2 + arcRadius, rect.origin.y);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, rect.origin.x, rect.origin.y);
    // arc start point
    CGPathAddLineToPoint(path, NULL, arcStartPoint.x, arcStartPoint.y);
    // arc
    CGPathAddArc(path, NULL, arcCenterPoint.x, arcCenterPoint.y, arcRadius, -M_PI, 0, 1);
    // arc end point
    CGPathAddLineToPoint(path, NULL, arcEndPoint.x, arcEndPoint.y);
    // top right
    CGPathAddLineToPoint(path, NULL, rect.origin.x + rect.size.width, rect.origin.y);
    // bottom right
    CGPathAddLineToPoint(path, NULL, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
    // bottom left
    CGPathAddLineToPoint(path, NULL, rect.origin.x, rect.origin.y + rect.size.height);
    // back to the origin
    CGPathAddLineToPoint(path, NULL, rect.origin.x, rect.origin.y);
    return path;
}



@end
