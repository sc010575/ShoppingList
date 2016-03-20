//
//  SCShoppingListTableViewController.m
//  ShoppingList
//
//  Created by Suman Chatterjee on 18/03/2016.
//  Copyright © 2016 Suman Chatterjee. All rights reserved.
//

#import "SCShoppingListTableViewController.h"
#import "SCShoppingItem.h"
#import "SCShoppingListCellTableViewCell.h"
#import "SCCheckoutTableViewController.h"

@interface SCShoppingListTableViewController ()

@end

@implementation SCShoppingListTableViewController

@synthesize shoppingLists;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.shoppingLists = [NSMutableArray new];
    for (NSDictionary *itemDictionary in [SCShoppingItem importShoppingList]) {
        SCShoppingItem *item = [[SCShoppingItem alloc] initWithDictionary:itemDictionary];
        [self.shoppingLists addObject:item];
    }
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Checkout" style:UIBarButtonItemStylePlain target:self action:@selector(checkoutAction:)];
     self.navigationItem.rightBarButtonItem = barButtonItem;
    
    self.title = @"Items";
    
    //We need this to accordingly update checkout button state, disabling it in case any items are added to basket
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shoppingListsHasChanged) name:SCAGoodsAmountChangedNotification object:nil];
    
    [self shoppingListsHasChanged];
    
    self.tableView.tableFooterView = [[UIView alloc] init];


    
}

- (void) shoppingListsHasChanged {
    
    //Calculate the total amount and show if the checkout button will enable or disable
    CGFloat totalPrice = 0;
    for (SCShoppingItem *item in self.shoppingLists) {
        totalPrice += item.price * item.amount;
    }
    //We either enable or disable the checkout button
    self.navigationItem.rightBarButtonItem.enabled = totalPrice > 0;
}


#pragma mark - checkOut Action

- (void)checkoutAction:(id)sender
{
    // Get reference to the destination view controller
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    SCCheckoutTableViewController * checkoutViewController  = [storyboard instantiateViewControllerWithIdentifier:@"SCCheckoutTableViewController"];
    [checkoutViewController setPurchasedItems:[[self preparePurchasedItems] mutableCopy]];

    [self.navigationController pushViewController:checkoutViewController animated:YES];


}

#pragma mark - SCShoppingListProtocal

- (NSArray*)preparePurchasedItems
{
    NSArray *purchasedItems = @[];
    for (SCShoppingItem *item in self.shoppingLists) {
        
        if (item.amount > 0) {
            purchasedItems = [purchasedItems arrayByAddingObject:item];
        }
    }
    return purchasedItems;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.shoppingLists.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SCShoppingListCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SCShoppingListCellTableViewCell class]) forIndexPath:indexPath];
    
    SCShoppingItem *shoppingListItem = self.shoppingLists[indexPath.row];
    //Configure the cell with the item
    [cell configureCellForItem:shoppingListItem];
    return cell;

}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"ShowCheckout"])
    {
        // Get reference to the destination view controller
        SCCheckoutTableViewController * checkoutViewController = [segue destinationViewController];
        
        NSArray *purchasedItems = @[];
        for (SCShoppingItem *item in self.shoppingLists) {
            
            if (item.amount > 0) {
                purchasedItems = [purchasedItems arrayByAddingObject:item];
            }
        }

        [checkoutViewController setPurchasedItems:[purchasedItems mutableCopy]];
    }}


@end
