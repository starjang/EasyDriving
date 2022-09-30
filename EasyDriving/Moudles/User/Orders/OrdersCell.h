//
//  OrdersCell.h
//  EasyDriving
//
//  Created by Mason on 2018/12/20.
//  Copyright © 2018 zmx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class EDUserOrder;

@interface OrdersCell : UITableViewCell

- (void)updateData:(EDUserOrder *)order;

@end

NS_ASSUME_NONNULL_END
