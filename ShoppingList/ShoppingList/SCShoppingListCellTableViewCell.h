//
//  SCShoppingListCellTableViewCell.h
//  ShoppingList
//
//  Created by Suman Chatterjee on 18/03/2016.
//  Copyright © 2016 Suman Chatterjee. All rights reserved.
//

//  This is a table cell that holds information about each item in the shoppinglists.

#import <UIKit/UIKit.h>

@class SCShoppingItem;

@interface SCShoppingListCellTableViewCell : UITableViewCell

- (void) configureCellForItem:(SCShoppingItem *)item;


@end
