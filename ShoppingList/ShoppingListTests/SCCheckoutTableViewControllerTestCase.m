//
//  SCCheckoutTableViewControllerTestCase.m
//  ShoppingList
//
//  Created by Suman Chatterjee on 18/03/2016.
//  Copyright © 2016 Suman Chatterjee. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SCCheckoutTableViewController.h"
#import "SCTableViewControllerTestCase.h"

@interface SCCheckoutTableViewControllerTestCase : SCTableViewControllerTestCase

@property (nonatomic, strong) SCCheckoutTableViewController *viewControllerUnderTest;

@end

@implementation SCCheckoutTableViewControllerTestCase

- (Class)viewControllerClassUnderTest {
    
    return [SCCheckoutTableViewControllerTestCase class];
}


- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}


@end
