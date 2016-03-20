//
//  SCShoppingListTableViewControllerTestCase.m
//  ShoppingList
//
//  Created by Suman Chatterjee on 18/03/2016.
//  Copyright © 2016 Suman Chatterjee. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SCShoppingListTableViewController.h"
#import "SCTableViewControllerTestCase.h"

@interface SCShoppingListTableViewControllerTestCase : SCTableViewControllerTestCase


@end

@implementation SCShoppingListTableViewControllerTestCase


- (Class)viewControllerClassUnderTest {
  
    return [SCShoppingListTableViewController class];
}



- (void)setUp {
    [super setUp];

}

- (void)tearDown {
    self.viewController = nil;
   [super tearDown];
}

#pragma mark - Tests



@end
