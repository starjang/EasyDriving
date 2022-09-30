//
//  PointsCell.h
//  EasyDriving
//
//  Created by Mason on 2018/12/25.
//  Copyright © 2018 zmx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class EDUserPoints;

@interface PointsCell : UITableViewCell

- (void)updateData:(EDUserPoints *)point;

@end

NS_ASSUME_NONNULL_END
