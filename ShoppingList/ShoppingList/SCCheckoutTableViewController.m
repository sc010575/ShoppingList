//
//  SCCheckoutTableViewController.m
//  ShoppingList
//
//  Created by Suman Chatterjee on 18/03/2016.
//  Copyright © 2016 Suman Chatterjee. All rights reserved.
//

#import "SCCheckoutTableViewController.h"
#import "SCCheckoutTableViewCell.h"
#import "SCCurrencyTableViewController.h"
#import "SCShoppingItem.h"

@interface SCCheckoutTableViewController ()

@property (nonatomic, weak) IBOutlet UILabel *totalValueLabel;
@property (nonatomic, strong) NSString *selectedCurrency;
@property (nonatomic) CGFloat priceInLocalCurrency;
@property (nonatomic) CGFloat priceInSelectedCurrency;

@end

@implementation SCCheckoutTableViewController

- (void) setPurchasedItems:(NSArray *)purchasedItems {
    _purchasedItems = purchasedItems;
    //Initialise with default values and reset the rest.
    [self.tableView reloadData];
    self.priceInLocalCurrency = 0;
    
    for (SCShoppingItem *item in purchasedItems) {
        self.priceInLocalCurrency += item.price * item.amount;
    }
    self.selectedCurrency = @"GBP";
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.selectedCurrency = @"GBP";
    [self updateTotalPriceLabel];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Updating the price label in case the value changed (for instance, if we converted it to other currency)
- (void) updateTotalPriceLabel {
    
    SCCheckoutTableViewController __weak *weakSelf = self;
    //Again, make sure we update the label in the main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        NSNumber *price = [NSNumber numberWithDouble:weakSelf.priceInLocalCurrency];
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.currencyCode = weakSelf.selectedCurrency;
        [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        weakSelf.totalValueLabel.text = [formatter stringFromNumber:price];
    });
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.purchasedItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    SCCheckoutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SCCheckoutTableViewCell class]) forIndexPath:indexPath];
    [cell configureCellForItem:self.purchasedItems[indexPath.row]];

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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"ShowCurrency"])
    {
        // Get reference to the destination view controller
        SCCurrencyTableViewController * currencyViewController = [segue destinationViewController];
        
    }}


@end
