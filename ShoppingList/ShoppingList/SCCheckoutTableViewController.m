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

@property (nonatomic, weak) IBOutlet UILabel  *totalValueLabel;
@property (nonatomic, weak) IBOutlet UILabel  *headerInstructionLabel;
@property (nonatomic, weak) IBOutlet UIButton *changeCurrencyButton;

@property (nonatomic) BOOL    gotCurrencyData;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndecator;

@end

@implementation SCCheckoutTableViewController

@synthesize purchasedItems;
@synthesize selectedCurrency;
@synthesize priceInLocalCurrency;
@synthesize newPriceWeGotInSelectedCurrency;

- (void) setPurchasedItems:(NSMutableArray *)thePurchasedItems {
    purchasedItems = thePurchasedItems;
    [self.tableView reloadData];
    [self calculateTotalPrice];
    self.priceInLocalCurrency = 0;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Basket";
    self.headerInstructionLabel.text = @"To remove items from the shopping lists, swipe the selected row. You can then remove it from shopping lists.";
    
    [[self.changeCurrencyButton layer] setBorderWidth:2.0f];
    [[self.changeCurrencyButton layer] setBorderColor:[UIColor blackColor].CGColor];
    
    self.selectedCurrency = SCLocalCurrency;
    [self updateTotalPriceLabel];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.gotCurrencyData = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//Updating the price label in case the value changed (for instance, if we converted it to other currency)
- (void) updateTotalPriceLabel {
    
    SCCheckoutTableViewController __weak *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        NSNumber *price = [NSNumber numberWithDouble:weakSelf.newPriceWeGotInSelectedCurrency];
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
     // Delete the row from the data source
     [self.purchasedItems removeObjectAtIndex:indexPath.row];
     [self calculateTotalPrice];

     [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
     [self updateTotalPriceLabel];

    }
 }

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Set NSString for button display text here.
    NSString *newTitle = @"Remove";
    return newTitle;
    
}



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

#pragma mark - Button action

- (IBAction)changeCurrencyAction:(id)sender {
    
    [self.activityIndecator startAnimating];
    SCCheckoutTableViewController __weak *weakSelf = self;
    [[SCCurrencyProviderService instance] getCurrenciesDetailsWithCompletion:^(NSDictionary *currencies) {
        
        [weakSelf.activityIndecator stopAnimating];
         weakSelf.gotCurrencyData = YES;
        [weakSelf performSegueWithIdentifier:@"ShowCurrency" sender:self];
        
    } failure:^(NSError *error) {

        [self alertForError:error];
        
    }];

    
}

#pragma mark - private function

- (void) setNewCurrency:(NSString *)theSelectedCurrency {
    self.selectedCurrency = theSelectedCurrency;
    [self.activityIndecator startAnimating];
    if (![self.selectedCurrency isEqualToString:SCLocalCurrency]) {
        
        [self.activityIndecator startAnimating];
        SCCheckoutTableViewController __weak *weakSelf = self;
        [[SCCurrencyProviderService instance] convertAmountInLocalCurrency:weakSelf.priceInLocalCurrency toCurrency:self.selectedCurrency withCompletion:^(NSDictionary *json) {
            [weakSelf.activityIndecator stopAnimating];
            weakSelf.newPriceWeGotInSelectedCurrency = [json[ScRequestedConvertedAmount] floatValue];
            [weakSelf updateTotalPriceLabel];
            //nslo
        } failure:^(NSError *error) {
            selectedCurrency = SCLocalCurrency;
             [weakSelf updateTotalPriceLabel];
            [self alertForError:error];
        }];
    }
}

- (void)alertForError:(NSError*) error
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.activityIndecator stopAnimating];
        
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Error"
                                   message:[error localizedDescription]
                                   preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    });
    
    
}

- (void)calculateTotalPrice
{
    self.priceInLocalCurrency = 0.0;
    for (SCShoppingItem *item in self.purchasedItems) {
        self.priceInLocalCurrency += item.price * item.amount;
    }
    self.newPriceWeGotInSelectedCurrency = self.priceInLocalCurrency;
    self.selectedCurrency = SCLocalCurrency;
    
}


@end
