//
//  XWPassbook.h
//  XWPassbook
//
//  Created by sutar on 4/2/15.
//  Copyright (c) 2015 Xin Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWPassbookPage.h"

extern NSString *const kXWPassbookNotificationCollapseOthers;
extern NSString *const kXWPassbookNotificationRestoreAll;

@interface XWPassbook : UIView
@property (nonatomic, strong) NSMutableArray *pages;

- (void)addPage:(XWPassbookPage *)page;
- (void)collapseAll;
@end
