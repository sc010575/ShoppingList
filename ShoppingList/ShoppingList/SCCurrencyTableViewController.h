//
//  SCCurrencyTableViewController.h
//  ShoppingList
//
//  Created by Suman Chatterjee on 18/03/2016.
//  Copyright © 2016 Suman Chatterjee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SCCurrencyTableViewControllerDelegate <NSObject>

@required
- (void) setNewCurrency:(NSString*)currency;

@end


@interface SCCurrencyTableViewController : UITableViewController

@property (nonatomic, weak) id<SCCurrencyTableViewControllerDelegate> delegate;

@end
