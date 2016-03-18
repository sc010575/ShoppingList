//
//  SCShoppingListCellTableViewCell.m
//  ShoppingList
//
//  Created by Suman Chatterjee on 18/03/2016.
//  Copyright © 2016 Suman Chatterjee. All rights reserved.
//

#import "SCShoppingListCellTableViewCell.h"
#import "SCShoppingItem.h"

@interface SCShoppingListCellTableViewCell()

@property (nonatomic, weak) IBOutlet UIImageView *itemImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *priceLabel;
@property (nonatomic, weak) IBOutlet UILabel *amountLabel;
@property (nonatomic, weak) IBOutlet UIStepper *amountStepper;

@property (nonatomic, strong) SCShoppingItem *item;

@end


@implementation SCShoppingListCellTableViewCell

- (void)awakeFromNib {

    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void) configureCellForItem:(SCShoppingItem *)item {
    _item = item;
    self.priceLabel.text = [item formattedPricePerUnit];
    self.titleLabel.text = item.name;
    self.itemImageView.image = [UIImage imageNamed:item.imageName];
    self.amountStepper.value = item.amount;
    [self numberOfItemChanged:self.amountStepper];
}

- (IBAction)numberOfItemChanged:(id)sender {
    
    if (sender == self.amountStepper) {
        self.item.amount = self.amountStepper.value;
        //To correctly show "1" or "21 can", but "2 cans".
        NSString *units = (self.item.amount % 10 == 1) && (self.item.amount != 11) ? self.item.units : [NSString stringWithFormat:@"%@s", self.item.units];
        self.amountLabel.text = [NSString stringWithFormat:@"Items: %li %@", (long)self.item.amount, units];
        
        //Send notification to  update button state, disabling it in case on items are selected
        [[NSNotificationCenter defaultCenter] postNotificationName:SCAGoodsAmountChangedNotification object:self.item];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
