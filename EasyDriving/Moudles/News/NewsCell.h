//
//  NewsCell.h
//  EasyDriving
//
//  Created by Mason on 2018/12/24.
//  Copyright © 2018 zmx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class EDNews;

@interface NewsCell : UITableViewCell

- (void)update:(EDNews *)news;

@end

NS_ASSUME_NONNULL_END
