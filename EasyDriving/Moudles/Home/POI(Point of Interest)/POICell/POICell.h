//
//  POICell.h
//  EasyDriving
//
//  Created by Mason on 2018/12/18.
//  Copyright © 2018 zmx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define yPOICellHeight 80

@protocol POIDataDelegate <NSObject>

- (void)poiCallMerchant:(NSString *)phoneNumber;
- (void)poiToNavigationInRow:(NSInteger)row;
- (void)poiOrderInRow:(NSInteger)row;

@end

@interface POICell : UITableViewCell

@property (nonatomic, weak) id<POIDataDelegate> delegate;
@property (nonatomic, strong) UILabel   *placeName;
@property (nonatomic, strong) UILabel   *placeDistance;
@property (nonatomic, strong) UILabel   *placeLocation;
@property (nonatomic, strong) UIButton  *orderBtn;
@property (nonatomic, strong) UIView    *telView;
@property (nonatomic, strong) NSString  *phoneNumber;
@property (nonatomic, assign) NSInteger row;

@end

NS_ASSUME_NONNULL_END
