//
//  SCCurrencyProviderService.h
//  ShoppingList
//
//  Created by Suman Chatterjee on 18/03/2016.
//  Copyright © 2016 Suman Chatterjee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h>

extern NSString* const SCLocalCurrency;

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
