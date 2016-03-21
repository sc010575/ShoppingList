//
//  SCCheckoutProtocol.h
//  ShoppingList
//
//  Created by Suman Chatterjee on 20/03/2016.
//  Copyright © 2016 Suman Chatterjee. All rights reserved.
//

//Protocol for SCCheckoutTableViewController.


#import <Foundation/Foundation.h>

@protocol SCCheckoutProtocol <NSObject>

@property (nonatomic, strong) NSMutableArray *purchasedItems;
@property (nonatomic, strong) NSString *selectedCurrency;
@property (nonatomic) CGFloat priceInLocalCurrency;
@property (nonatomic) CGFloat newPriceWeGotInSelectedCurrency;

- (void) setNewCurrency:(NSString *)selectedCurrency;

@end
