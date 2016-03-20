//
//  SCCurrencyTableViewCell.h
//  ShoppingList
//
//  Created by Suman Chatterjee on 19/03/2016.
//  Copyright © 2016 Suman Chatterjee. All rights reserved.
//

//  This is a table cell that holds information about each currencies and its description.

#import <UIKit/UIKit.h>

@interface SCCurrencyTableViewCell : UITableViewCell

- (void) configureCellForCountry:(NSString *)country withCode:(NSString*) currencyCode;

@end
