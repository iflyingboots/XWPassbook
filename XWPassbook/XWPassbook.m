//
//  XWPassbook.m
//  XWPassbook
//
//  Created by sutar on 4/2/15.
//  Copyright (c) 2015 Xin Wang. All rights reserved.
//

#import "XWPassbook.h"

NSString *const kXWPassbookNotificationCollapseOthers = @"XWPassbookNotificationCollapseOthers";
NSString *const kXWPassbookNotificationRestoreAll = @"XWPassbookNotificationRestoreAll";
const CGFloat kAnimationDuration = .5f;

@implementation XWPassbook

#pragma mark - Life cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _pages = [NSMutableArray new];
        [self registerNotification];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Public
- (void)addPage:(XWPassbookPage *)page
{
    if (page == nil) {
        return;
    }
    
    [_pages addObject:page];
    [self addSubview:page];

}

- (void)collapseAllExcept:(NSInteger)index
{
    for (NSInteger i = 0; i < _pages.count; i++) {
        if (i == index) {
            continue;
        }
        XWPassbookPage *page = _pages[i];
        [page collapse];
    }

}

- (void)collapseAll
{
    [self collapseAllExcept:-1];
}

- (void)restoreAllExcept:(NSInteger)index
{
    for (NSInteger i = 0; i < _pages.count; i++) {
        if (i == index) {
            continue;
        }
        XWPassbookPage *page = _pages[i];
        [page restore];
    }
}

- (void)restoreAll
{
    [self restoreAllExcept:-1];
}


#pragma mark - Layout
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat pageMargin = 0;
    CGFloat paddingTop = 50.f;
    if (_pages.count > 0) {
       pageMargin = (self.bounds.size.height - paddingTop) / _pages.count;
    }

    for (NSInteger i = 0; i < _pages.count; i++) {
        XWPassbookPage *page = _pages[i];

        page.frame = ({
            CGRect frame = page.frame;
            frame.origin.y = i * pageMargin + paddingTop;
            frame;
        });
        page.index = i;
        page.originalFrame = page.frame;
    }
}

#pragma mark - Notification
- (void)registerNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleRestoreAllNotification:) name:kXWPassbookNotificationRestoreAll object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCollapseOthersNotification:) name:kXWPassbookNotificationCollapseOthers object:nil];
}

- (void)handleRestoreAllNotification:(NSNotification *)notification
{
    if (! [notification.object isKindOfClass:[XWPassbookPage class]]) {
        return;
    }
    XWPassbookPage *page = (XWPassbookPage *)notification.object;
    [self restoreAllExcept:page.index];
    
}

- (void)handleCollapseOthersNotification:(NSNotification *)notification
{
    if (! [notification.object isKindOfClass:[XWPassbookPage class]]) {
        return;
    }
    XWPassbookPage *page = (XWPassbookPage *)notification.object;
    [self collapseAllExcept:page.index];
}

@end
