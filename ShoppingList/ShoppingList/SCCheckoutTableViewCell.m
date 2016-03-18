//
//  SCCheckoutTableViewCell.m
//  ShoppingList
//
//  Created by Suman Chatterjee on 18/03/2016.
//  Copyright © 2016 Suman Chatterjee. All rights reserved.
//

#import "SCCheckoutTableViewCell.h"
#import "SCShoppingItem.h"

@interface SCCheckoutTableViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *subtitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *amountLabel;
@property (nonatomic, strong)SCShoppingItem *item;
@end


@implementation SCCheckoutTableViewCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void) configureCellForItem:(SCShoppingItem *)item{
    _item = item;
    self.titleLabel.text = item.name;
    self.subtitleLabel.text = [item formattedPricePerUnit];
    self.amountLabel.text = [NSString stringWithFormat:@"%li ✕ %@", (long)item.amount, [item formattedPrice]];
}

@end
