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


@property (nonatomic, strong) NSMutableArray *shoppingLists;

@end

@implementation SCShoppingListTableViewController

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
    //We calculate the total amount (in case we may need to show it in the UI)
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
    
    NSArray *purchasedItems = @[];
    for (SCShoppingItem *item in self.shoppingLists) {
        
        if (item.amount > 0) {
            purchasedItems = [purchasedItems arrayByAddingObject:item];
        }
    }
    
    [checkoutViewController setPurchasedItems:[purchasedItems mutableCopy]];

    [self.navigationController pushViewController:checkoutViewController animated:YES];


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



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


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
