//
//  SCShoppingItem.m
//  ShoppingList
//
//  Created by Suman Chatterjee on 18/03/2016.
//  Copyright © 2016 Suman Chatterjee. All rights reserved.
//

#import "SCShoppingItem.h"

NSString* const SCShoppingListNameKey = @"name";
NSString* const SCShoppingListImageKey = @"image";
NSString* const SCShoppingListPriceKey = @"price";
NSString* const SCShoppingListUnitsKey = @"units";
NSString* const SCAGoodsAmountChangedNotification = @"kGoodsAmountChangedNotification";

static NSString* KShoppingListFileName = @"ShoppingList.json";


@interface SCShoppingItem ()

@property (nonatomic, strong) NSString *name;
@property (nonatomic) CGFloat price;
@property (nonatomic, strong) NSString *units;
@property (nonatomic, strong) NSString *imageName;

@end

@implementation SCShoppingItem

#pragma mark - Static method

+ (NSArray *)importShoppingList
{
    // Generally not a good idea to do this in a real app.
    // This data will live in memory forever.
    static NSArray *shoppingListArray = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *dataURL = [[NSBundle mainBundle] URLForResource:KShoppingListFileName withExtension:nil];
        NSData *shoppingListData = [NSData dataWithContentsOfURL:dataURL];
        NSError *err = nil;
        shoppingListArray = [NSJSONSerialization JSONObjectWithData:shoppingListData options:kNilOptions error:&err];
        NSAssert(err == nil, @"Error importing shopping list data from JSON: %@", err);
    });
    return shoppingListArray;
}


#pragma mark - other method

- (instancetype) initWithDictionary:(NSDictionary*)dictionary {
    if (self = [super init]) {
        self.price = [dictionary[SCShoppingListPriceKey] floatValue];
        self.name = dictionary[SCShoppingListNameKey];
        self.units = dictionary[SCShoppingListUnitsKey];
        self.imageName = dictionary[SCShoppingListImageKey];
    }
    return self;
}

- (NSString*)formattedPrice {
    return self.price >= 1 ? [NSString stringWithFormat:@"£%.2f", self.price] :
    [NSString stringWithFormat:@"%.fp", self.price*100];
}

- (NSString*)formattedPricePerUnit {
    return [NSString stringWithFormat:@"%@/%@", [self formattedPrice], self.units];
}


@end

