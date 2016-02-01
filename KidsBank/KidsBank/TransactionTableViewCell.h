//
//  TransactionTableViewCell.h
//  KidsBank
//
//  Created by Jung Geon Choi on 2016-01-31.
//  Copyright © 2016 Jung Geon Choi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransactionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *reason;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
