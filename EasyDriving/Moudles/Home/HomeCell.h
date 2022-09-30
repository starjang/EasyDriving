//
//  HomeCell.h
//  EasyDriving
//
//  Created by Mason on 2018/11/29.
//  Copyright © 2018 zmx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeItem;

NS_ASSUME_NONNULL_BEGIN

@interface HomeCell : UICollectionViewCell

- (void)update:(HomeItem *)item;

@end

NS_ASSUME_NONNULL_END
