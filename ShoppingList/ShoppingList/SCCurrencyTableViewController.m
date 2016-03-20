//
//  SCCurrencyTableViewController.m
//  ShoppingList
//
//  Created by Suman Chatterjee on 18/03/2016.
//  Copyright © 2016 Suman Chatterjee. All rights reserved.
//

#import "SCCurrencyTableViewController.h"
#import "SCCurrencyTableViewCell.h"
#import "SCCurrencyProviderService.h"


@interface SCCurrencyTableViewController ()

@property (nonatomic, strong) NSArray * currencies;
@property (nonatomic, strong) NSDictionary *countryWiseCurrencies;
@property (nonatomic, strong) NSArray * selectionIndexTitleList;
@end

@implementation SCCurrencyTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Currency lists";
    self.countryWiseCurrencies = [[SCCurrencyProviderService instance]getCachedCurrency];
    self.currencies = [[self.countryWiseCurrencies allKeys] sortedArrayUsingComparator:^NSComparisonResult(NSString *key1, NSString *key2) {
        return [key1 compare:key2];
    }];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.currencies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    SCCurrencyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SCCurrencyTableViewCell class]) forIndexPath:indexPath];
    
    NSString *currencyKey = self.currencies[indexPath.row];
    [cell configureCellForCountry:self.countryWiseCurrencies[currencyKey] withCode:currencyKey];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
     if ([self.delegate respondsToSelector:@selector(setNewCurrency:)]) {
        [self.delegate setNewCurrency:self.currencies[indexPath.row]];
    }
   [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Search bar


@end
