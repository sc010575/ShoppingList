//
//  SCCurrencyProviderService.h
//  ShoppingList
//
//  Created by Suman Chatterjee on 18/03/2016.
//  Copyright © 2016 Suman Chatterjee. All rights reserved.
//

//  This is the network request manager singleton class. I use AFNetworking for the Network connection, using cocoapods.
//  pods are in the box therefore it should run the application withoud any problem. Because of the currency descriptions are remain same in the life cycly of the app, I cached it after the first fatch so that we can reduce the network cost.


#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h>


extern NSString* const SCLocalCurrency;
extern NSString* const  ScRequestedConvertedAmount;

typedef void (^SuccessBlock)(NSDictionary* json);
typedef void (^FailureBlock)(NSError* error);


@interface SCCurrencyProviderService : NSObject

+ (instancetype) instance;

- (void) getCurrenciesDetailsWithCompletion:(SuccessBlock)success
                             failure:(FailureBlock)failure;

- (NSDictionary*)getCachedCurrency;

- (void) convertAmountInLocalCurrency:(CGFloat)amount
                           toCurrency:(NSString*)currency
                       withCompletion:(SuccessBlock)success
                              failure:(FailureBlock)failure;

@end
