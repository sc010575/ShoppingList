//
//  SCCurrencyProviderServiceTestCase.m
//  ShoppingList
//
//  Created by Suman Chatterjee on 18/03/2016.
//  Copyright © 2016 Suman Chatterjee. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SCCurrencyProviderService.h"

@interface SCCurrencyProviderServiceTestCase : XCTestCase

@property (nonatomic, strong) NSDictionary *loadedCurrenciesDictionary;

@end

@implementation SCCurrencyProviderServiceTestCase

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLoadCurrencies {
    XCTestExpectation *currenciesExpectiation = [self expectationWithDescription:@"Currencies load"];
    
    [[SCCurrencyProviderService instance] getCurrenciesDetailsWithCompletion:^(NSDictionary *json) {
        XCTAssert(json);
        [currenciesExpectiation fulfill];
        self.loadedCurrenciesDictionary = json;
        NSArray * currenciesKey =  [self.loadedCurrenciesDictionary allKeys];

        
        NSDictionary * getCachedCurrenciesDict = [[SCCurrencyProviderService instance] getCachedCurrency];

        NSArray * cachedArray = [getCachedCurrenciesDict allKeys];
        XCTAssertTrue(currenciesKey.count == cachedArray.count, @" Cached Array data should match \"%s\"" ,__PRETTY_FUNCTION__);

    } failure:^(NSError *error) {
        XCTFail(@"Couldn't load the list of currencies");
        [currenciesExpectiation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:20 handler:^(NSError *error) {
        XCTAssert(YES, @"Finished currencies request test");
    }];
}

- (void)testGetCurrenciesPerformance {
    [self measureBlock:^{
        [self testLoadCurrencies];
    }];
}

- (void)testCurrencieConversion {
    XCTestExpectation *currenciesExpectiation = [self expectationWithDescription:@"Currencies conversion"];
    
    [[SCCurrencyProviderService instance] convertAmountInLocalCurrency:80.50 toCurrency:@"USD" withCompletion:^(NSDictionary *json) {
        XCTAssert(json);
        [currenciesExpectiation fulfill];
    } failure:^(NSError *error) {
        XCTFail(@"Couldn't convert the amount");
        [currenciesExpectiation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:20 handler:^(NSError *error) {
        XCTAssert(YES, @"Finished currencies request test");
    }];
}

- (void)testCurrencieConversionPerformance {
    [self measureBlock:^{
        [self testLoadCurrencies];
    }];
}


@end
