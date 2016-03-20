//
//  SCShoppingListUnitTestCase.m
//  ShoppingList
//
//  Created by Suman Chatterjee on 18/03/2016.
//  Copyright © 2016 Suman Chatterjee. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SCShoppingItem.h"

@interface SCShoppingListUnitTestCase : XCTestCase

@property (nonatomic, strong) SCShoppingItem *item;

@end

@implementation SCShoppingListUnitTestCase

- (void)setUp {
    [super setUp];
    self.item = [[SCShoppingItem alloc] initWithDictionary:@{SCShoppingListNameKey : @"Peas", SCShoppingListPriceKey : @0.95f, SCShoppingListUnitsKey : @"bag", SCShoppingListImageKey : @"peas"}];
    self.item.amount = 3;

}

- (void)tearDown {
    self.item = nil;
    [super tearDown];
}


- (void)testImportShoppingList {

    NSArray *importedArray = [SCShoppingItem importShoppingList];
    XCTAssertTrue(importedArray.count != 0, @"Shopping list must have Item");
    

}

- (void)testShoppingItemWhatIsImported
{
    NSArray *importedArray = [SCShoppingItem importShoppingList];
    NSDictionary *itemDictionary = importedArray.firstObject;
    SCShoppingItem *item = [[SCShoppingItem alloc] initWithDictionary:itemDictionary];
    
    XCTAssertTrue([item.name isEqualToString:self.item.name], @"Data should match \"%s\"" ,__PRETTY_FUNCTION__);

}

- (void)testProperties {
    XCTAssert(self.item.name, @"Name must not be nil");
    XCTAssert(self.item.units, @"Units must not be nil");
    XCTAssert(self.item.imageName, @"Image name must not be nil");
    XCTAssert(self.item.price > 0, @"Price should be positive");
    XCTAssert(self.item.amount >= 0, @"Amount should be more or equal to zero");
}

- (void) testFormattedPrices {
    XCTAssert([[self.item formattedPrice] length], @"Formatted price should return a valid string");
    XCTAssert([[self.item formattedPricePerUnit] length], @"Formatted price per unit should return a valid string");

    NSString * testFormatProperty = @"95p/bag";
    NSArray *importedArray = [SCShoppingItem importShoppingList];
    NSDictionary *itemDictionary = importedArray.firstObject;
    SCShoppingItem *item = [[SCShoppingItem alloc] initWithDictionary:itemDictionary];

    NSString *formatString =  [item formattedPricePerUnit];
    
    XCTAssertTrue([formatString isEqualToString:testFormatProperty], @"Formatted string should match \"%s\"" ,__PRETTY_FUNCTION__);

}



@end
