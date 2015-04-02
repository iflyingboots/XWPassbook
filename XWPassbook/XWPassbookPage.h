//
//  XWPassbookPage.h
//  XWPassbook
//
//  Created by sutar on 4/2/15.
//  Copyright (c) 2015 Xin Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, XWPassbookPageState) {
    XWPassbookPageStateNormal = 1,
    XWPassbookPageStatePresent,
    XWPassbookPageStateCollapsed,
};

@interface XWPassbookPage : UIView

@property (nonatomic, assign) CGRect originalFrame;
@property (nonatomic, assign) XWPassbookPageState state;
@property (nonatomic, strong) UIColor *pageBackgroundColor;
@property (nonatomic, assign) NSInteger index;

- (void)present;
- (void)restore;
- (void)collapse;


@end
