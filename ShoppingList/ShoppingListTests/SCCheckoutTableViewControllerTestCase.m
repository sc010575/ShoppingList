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
#import "SCShoppingItem.h"


@interface SCCheckoutTableViewController (ForTests)

@property (nonatomic, weak) IBOutlet UILabel *totalValueLabel;

@end


@interface SCCheckoutTableViewControllerTestCase : SCTableViewControllerTestCase

@end

@implementation SCCheckoutTableViewControllerTestCase

- (Class)viewControllerClassUnderTest {
    
    return [SCCheckoutTableViewController class];
}


- (void)setUp {
    [super setUp];
    SCShoppingItem *item = [[SCShoppingItem alloc] initWithDictionary:@{SCShoppingListNameKey : @"Peas", SCShoppingListPriceKey : @0.95f, SCShoppingListUnitsKey : @"bag", SCShoppingListImageKey : @"peas"}];
    item.amount = 3;
    
    XCTAssert(item, @"Failed to create a ASGoodsItem mocking object");
    ((SCCheckoutTableViewController*)self.viewController).purchasedItems = [@[item] mutableCopy];

}

- (void)tearDown {
    [super tearDown];
}

#pragma mark - Tests

- (void)testTableViewNumberOfRowsInSection {
    NSInteger expectedRows = 1;
    XCTAssertTrue([((SCCheckoutTableViewController*)self.viewController) tableView:((SCCheckoutTableViewController*)self.viewController).tableView numberOfRowsInSection:0] == expectedRows, @"Table has incorrect number of rows");
}

- (void)testOutlets {
    XCTAssert(((SCCheckoutTableViewController*)self.viewController).totalValueLabel, @"Total label outlet must not be nil");
}

- (void)testTotalLabel {
    XCTAssert([((SCCheckoutTableViewController*)self.viewController).totalValueLabel.text length], @"Total label must contain the value");
}

@end
