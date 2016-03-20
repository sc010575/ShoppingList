//
//  SCShoppingItem.h
//  ShoppingList
//
//  Created by Suman Chatterjee on 18/03/2016.
//  Copyright © 2016 Suman Chatterjee. All rights reserved.
//

//A class representing a single shopping item.

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h>


extern NSString* const SCShoppingListImageKey;
extern NSString* const SCShoppingListNameKey;
extern NSString* const SCShoppingListPriceKey;
extern NSString* const SCShoppingListUnitsKey;
extern NSString* const SCAGoodsAmountChangedNotification;


@interface SCShoppingItem : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) CGFloat price;
@property (nonatomic) NSInteger amount;
@property (nonatomic, readonly) NSString *units;
@property (nonatomic, readonly) NSString *imageName;

- (instancetype) initWithDictionary:(NSDictionary*)dictionary;

// Helper methods
- (NSString*)formattedPricePerUnit;
- (NSString*)formattedPrice;

// Class method
+ (NSArray *)importShoppingList;


@end
