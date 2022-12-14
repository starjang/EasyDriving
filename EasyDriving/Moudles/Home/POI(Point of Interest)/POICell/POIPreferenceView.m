//
//  POIPreferenceView.m
//  偏好设置
//
//  Created by Mason on 2018/12/19.
//  Copyright © 2018 zmx. All rights reserved.
//


#import "POIPreferenceView.h"

#define kFinishButtonHeight     40.0f
#define kOptionTableViewHieght  200.0f
#define kTableViewHeaderHeight  30.0f
#define kTableViewCellHeight    50.0f

@interface POIPreferenceView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UITableView *optionTableView;
@property (nonatomic, strong) NSArray *sections;
@property (nonatomic, strong) NSArray *options;
@property (nonatomic, strong) UISegmentedControl *viewModeSeg;
@property (nonatomic, strong) UISegmentedControl *nightTypeSeg;
@property (nonatomic, strong) UIButton *finishButton;

@end

@implementation POIPreferenceView

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        
        [self initProperties];
        [self createPreferenceView];
    }
    
    return self;
}

- (void)initProperties {
    
    self.sections = @[@"偏好设置"];
    
    self.options = @[@[@"跟随模式", @"昼夜模式"]];
}

- (void)createPreferenceView {
    
    [self initMaskView];
    
    [self initTableView];
    
    [self initFinishButton];
}

- (void)initMaskView {
    
    _maskView = [[UIView alloc] initWithFrame:self.bounds];
    _maskView.backgroundColor = [UIColor grayColor];
    _maskView.alpha = 0.5;
    _maskView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self addSubview:_maskView];
}

- (void)initTableView {
    
    _optionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds) - kFinishButtonHeight - kOptionTableViewHieght, CGRectGetWidth(self.bounds), kOptionTableViewHieght)
                                                    style:UITableViewStylePlain];
    _optionTableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    _optionTableView.backgroundColor = [UIColor whiteColor];
    _optionTableView.delegate = self;
    _optionTableView.dataSource = self;
    _optionTableView.allowsSelection = NO;
    
    [self addSubview:_optionTableView];
}

- (void)initFinishButton {
    
    _finishButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds) - kFinishButtonHeight, CGRectGetWidth(self.bounds), kFinishButtonHeight)];
    _finishButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    [_finishButton setBackgroundColor:[UIColor blueColor]];
    [_finishButton setTitle:@"完 成" forState:UIControlStateNormal];
    [_finishButton addTarget:self action:@selector(finishButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_finishButton];
}

#pragma mark - TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return kTableViewHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kTableViewCellHeight;
}

#pragma mark - TableView DataSource Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _sections.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return _sections[section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_options[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *optionName = _options[indexPath.section][indexPath.row];
    
    if ([optionName isEqualToString:@"跟随模式"])
    {
        return [self tableViewCellForViewMode];
    }
    else if ([optionName isEqualToString:@"昼夜模式"])
    {
        return [self tableViewCellForNightType];
    }
    
    return nil;
}

#pragma mark - Custom TableView Cell
- (UITableViewCell *)tableViewCellForViewMode {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ViewModeCellIdentifier"];
    
    _viewModeSeg = [[UISegmentedControl alloc] initWithItems:@[@"正北朝上" , @"车头朝上"]];
    [_viewModeSeg setFrame:CGRectMake(160, (kTableViewCellHeight - 30)/2.0, 150, 30)];
    _viewModeSeg.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [_viewModeSeg setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    [_viewModeSeg addTarget:self action:@selector(viewModeSegmentedControlAction:) forControlEvents:UIControlEventValueChanged];
    
    UILabel *optionNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 120, kTableViewCellHeight)];
    optionNameLabel.textAlignment = NSTextAlignmentLeft;
    optionNameLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    optionNameLabel.font = [UIFont systemFontOfSize:18];
    optionNameLabel.text = @"跟随模式:";
    
    if (self.trackingMode == AMapNaviViewTrackingModeMapNorth)
    {
        [_viewModeSeg setSelectedSegmentIndex:0];
    }
    else if (self.trackingMode == AMapNaviViewTrackingModeCarNorth)
    {
        [_viewModeSeg setSelectedSegmentIndex:1];
    }
    
    [cell.contentView addSubview:optionNameLabel];
    [cell.contentView addSubview:_viewModeSeg];
    
    return cell;
}

- (UITableViewCell *)tableViewCellForNightType {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ViewModeCellIdentifier"];
    
    UILabel *optionNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 120, kTableViewCellHeight)];
    optionNameLabel.textAlignment = NSTextAlignmentLeft;
    optionNameLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    optionNameLabel.font = [UIFont systemFontOfSize:18];
    optionNameLabel.text = @"昼夜模式:";
    
    _nightTypeSeg = [[UISegmentedControl alloc] initWithItems:@[@"白天" , @"黑夜"]];
    _nightTypeSeg.frame = CGRectMake(160, (kTableViewCellHeight - 30)/2.0, 150, 30);
    _nightTypeSeg.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [_nightTypeSeg setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    [_nightTypeSeg addTarget:self action:@selector(nightTypeSegmentedControlAction:) forControlEvents:UIControlEventValueChanged];
    
    [_nightTypeSeg setSelectedSegmentIndex:self.showNightType];
    
    [cell.contentView addSubview:optionNameLabel];
    [cell.contentView addSubview:_nightTypeSeg];
    
    return cell;
}

#pragma mark - UISegmentedControl Action
- (void)viewModeSegmentedControlAction:(id)sender {
    
    NSInteger selectedIndex = [(UISegmentedControl *)sender selectedSegmentIndex];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(PreferenceViewTrackingModeChangeTo:)]) {
        
        [self.delegate PreferenceViewTrackingModeChangeTo:(AMapNaviViewTrackingMode)selectedIndex];
    }
}

- (void)nightTypeSegmentedControlAction:(id)sender {
    
    NSInteger selectedIndex = [(UISegmentedControl *)sender selectedSegmentIndex];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(PreferenceViewNightTypeChangeTo:)]) {
        
        [self.delegate PreferenceViewNightTypeChangeTo:selectedIndex];
    }
}

#pragma mark - Finish Button Action
- (void)finishButtonAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(preferenceViewFinishButtonClicked)]) {
        
        [self.delegate preferenceViewFinishButtonClicked];
    }
}

@end
