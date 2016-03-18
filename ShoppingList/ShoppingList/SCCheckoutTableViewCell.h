//
//  SCCheckoutTableViewCell.h
//  ShoppingList
//
//  Created by Suman Chatterjee on 18/03/2016.
//  Copyright © 2016 Suman Chatterjee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCShoppingItem;

@interface SCCheckoutTableViewCell : UITableViewCell

- (void) configureCellForItem:(SCShoppingItem *)item;

@end
