//
//  SCCurrencyTableViewCell.m
//  ShoppingList
//
//  Created by Suman Chatterjee on 19/03/2016.
//  Copyright © 2016 Suman Chatterjee. All rights reserved.
//

#import "SCCurrencyTableViewCell.h"

@interface SCCurrencyTableViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *currencyLabel;
@property (nonatomic, weak) IBOutlet UILabel *currencyCodeLabel;

@end


@implementation SCCurrencyTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void) configureCellForCountry:(NSString *)country withCode:(NSString*) currencyCode{
    
    self.currencyLabel.text = country;
    self.currencyCodeLabel.text = currencyCode;
    
}


@end
