//
//  SCShoppingListProtocol.h
//  ShoppingList
//
//  Created by Suman Chatterjee on 20/03/2016.
//  Copyright © 2016 Suman Chatterjee. All rights reserved.
//

//Protocol for SCShoppingListTableViewController.

#import <Foundation/Foundation.h>

@protocol SCShoppingListProtocol <NSObject>

@property (nonatomic, strong) NSMutableArray *shoppingLists;

- (NSArray*)preparePurchasedItems;

@end
