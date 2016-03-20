//
//  SCBaseViewControllerTestCase.h
//  ShoppingList
//
//  Created by Suman Chatterjee on 20/03/2016.
//  Copyright © 2016 Suman Chatterjee. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface SCBaseViewControllerTestCase : XCTestCase

@property (nonatomic, strong) UIViewController *viewController;

- (Class)viewControllerClassUnderTest;

@end
