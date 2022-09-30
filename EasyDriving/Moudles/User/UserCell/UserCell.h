//
//  UserCell.h
//  EasyDriving
//
//  Created by Mason on 2018/11/26.
//  Copyright © 2018 zmx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserItem;

NS_ASSUME_NONNULL_BEGIN

@interface UserCell : UITableViewCell

- (void)update:(UserItem *)item;

@end

NS_ASSUME_NONNULL_END
