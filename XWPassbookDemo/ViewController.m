//
//  ViewController.m
//  XWPassbookDemo
//
//  Created by sutar on 4/2/15.
//  Copyright (c) 2015 Xin Wang. All rights reserved.
//

#import "ViewController.h"
#import "XWPassbook.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XWPassbookPage *passbookPage1 = [[XWPassbookPage alloc] init];
    passbookPage1.pageBackgroundColor = [UIColor colorWithRed:200.0/255.0 green:22.0/255.0 blue:120.0/255.0 alpha:1.0];
    
    XWPassbookPage *passbookPage2 = [[XWPassbookPage alloc] init];
    passbookPage2.pageBackgroundColor = [UIColor colorWithRed:2.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0];
    
    XWPassbookPage *passbookPage3 = [[XWPassbookPage alloc] init];
    passbookPage3.pageBackgroundColor = [UIColor colorWithRed:222.0/255.0 green:992.0/255.0 blue:10.0/255.0 alpha:1.0];
    
    XWPassbookPage *passbookPage4 = [[XWPassbookPage alloc] init];
    passbookPage4.pageBackgroundColor = [UIColor colorWithRed:20.0/255.0 green:99.0/255.0 blue:120.0/255.0 alpha:1.0];
    

    XWPassbook *passbook = [[XWPassbook alloc] initWithFrame:self.view.bounds];
    [passbook addPage:passbookPage1];
    [passbook addPage:passbookPage2];
    [passbook addPage:passbookPage3];
    [passbook addPage:passbookPage4];
    
    [self.view addSubview:passbook];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
