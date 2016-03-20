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
#import "SCShoppingItem.h"

@interface SCShoppingListTableViewControllerTestCase : SCTableViewControllerTestCase

@property (nonatomic, strong) NSArray * arrayOfItem;

@end

@implementation SCShoppingListTableViewControllerTestCase


- (Class)viewControllerClassUnderTest {
  
    return [SCShoppingListTableViewController class];
}



- (void)setUp {
    [super setUp];
    self.arrayOfItem = [SCShoppingItem importShoppingList];

}

- (void)tearDown {
    self.viewController = nil;
   [super tearDown];
}

#pragma mark - Tests

- (void)testNumberOfItemInShoppingLists
{
    
    
    NSMutableArray * testArrayOfItems = ((SCShoppingListTableViewController*)self.viewController).shoppingLists;
    XCTAssertTrue(self.arrayOfItem.count == testArrayOfItems.count, @"Not all items are loaded from the JSON file \"%s\"" ,__PRETTY_FUNCTION__);

}

- (void) testPreparePurchasedItems
{
    NSMutableArray * testArrayOfItems = ((SCShoppingListTableViewController*)self.viewController).shoppingLists;
    
    BOOL amountTisTime = NO;
    for(SCShoppingItem *item in testArrayOfItems)
    {
        if(!amountTisTime){
            item.amount = 10;
            amountTisTime = YES;
        }else{
            amountTisTime = NO;
        }
    }
    ((SCShoppingListTableViewController*)self.viewController).shoppingLists = testArrayOfItems;
    
    NSArray *perchasedItem = [((SCShoppingListTableViewController*)self.viewController) preparePurchasedItems];

    XCTAssertTrue(perchasedItem.count == 3, @"preparePurchasedItems not functioning correctly \"%s\"" ,__PRETTY_FUNCTION__);

}


@end
