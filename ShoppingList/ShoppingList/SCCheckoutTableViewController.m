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
#import "SCCurrencyProviderService.h"
#import "SCShoppingItem.h"

@interface SCCheckoutTableViewController ()<SCCurrencyTableViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UILabel *totalValueLabel;
@property (nonatomic, strong) NSString *selectedCurrency;
@property (nonatomic) CGFloat priceInLocalCurrency;
@property (nonatomic) CGFloat newPriceWeGotInSelectedCurrency;
@property (nonatomic) BOOL    gotCurrencyData;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndecator;

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
    self.selectedCurrency = SCLocalCurrency;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Basket";
    self.selectedCurrency = SCLocalCurrency;
    [self updateTotalPriceLabel];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.gotCurrencyData = false;
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


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Make sure your segue name in storyboard is the same as this line
    
    if ([[segue identifier] isEqualToString:@"ShowCurrency"])
    {
        // Get reference to the destination view controller
        SCCurrencyTableViewController * currencyViewController = [segue destinationViewController];
        currencyViewController.delegate = self;
        self.gotCurrencyData = NO;

    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    if([identifier isEqualToString:@"ShowCurrency"] && self.gotCurrencyData)
    {
        return YES;
    }
    return NO;
 
}

- (IBAction)changeCurrencyAction:(id)sender {
    
    [self.activityIndecator startAnimating];
    SCCheckoutTableViewController __weak *weakSelf = self;
    [[SCCurrencyProviderService instance] getCurrenciesDetailsWithCompletion:^(NSDictionary *currencies) {
        
        [weakSelf.activityIndecator stopAnimating];
         weakSelf.gotCurrencyData = YES;
        [weakSelf performSegueWithIdentifier:@"ShowCurrency" sender:self];
    } failure:^(NSError *error) {
        NSLog(@"fail");
        //Show alert
    }];

    
}


- (void) setNewCurrency:(NSString *)selectedCurrency {
    self.selectedCurrency = selectedCurrency;
    [self.activityIndecator startAnimating];
    if (![self.selectedCurrency isEqualToString:SCLocalCurrency]) {
        
        [self.activityIndecator startAnimating];
        SCCheckoutTableViewController __weak *weakSelf = self;
        [[SCCurrencyProviderService instance] convertAmountInLocalCurrency:weakSelf.priceInLocalCurrency toCurrency:self.selectedCurrency withCompletion:^(NSDictionary *json) {
            //nslo
        } failure:^(NSError *error) {
            //nsn
        }];
    }
//        ASCheckoutTableViewController __weak *weakSelf = self;
//        //Make the request to convert the price
//        [ASCurrenciesService convertAmountInLocalCurrency:weakSelf.priceInLocalCurrency toCurrency:_selectedCurrency withCompletion:^(NSDictionary *json) {
//            weakSelf.priceInSelectedCurrency = [json[ASRequestArgumentAmount] floatValue];
//            [weakSelf updatePriceLabel];
//        } failure:^(NSError *error) {
//            [weakSelf handleConnectionError:error];
//            //Fall back to local currency
//            _selectedCurrency = ASLocalCurrency;
//            weakSelf.priceInSelectedCurrency = weakSelf.priceInLocalCurrency;
//            [weakSelf updatePriceLabel];
//        }];
//    }
//    else {
//        //If the local currency is selected, we don't make any requests
//        self.priceInSelectedCurrency = self.priceInLocalCurrency;
//        [self updatePriceLabel];
//    }
}

@end
