//
//  POIAddOrderVC.m
//  EasyDriving
//
//  Created by Mason on 2018/12/20.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "POIAddOrderVC.h"
#import "BaseHeader.h"
#import "HomeItem.h"
#import "HomeItemFactory.h"
#import <MessageUI/MessageUI.h>
#import "EDUserStore.h"
#import "UserItem.h"
#import "EDWebUserConnect.h"
#import "EDWebUserAddOrderRequest.h"

@interface POIAddOrderVC ()<UIPickerViewDelegate, UIPickerViewDataSource, MFMessageComposeViewControllerDelegate>

@property (nonatomic, strong) UIButton *leftNavBtn;
@property (nonatomic, strong) UIView *imgBgView;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *placeName;
@property (nonatomic, strong) UILabel *placeAddress;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSMutableArray *pickerLists;
@property (nonatomic, strong) NSString *pickerSelected;
@property (nonatomic, strong) Button *orderBtn;

@end

@implementation POIAddOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initViews];
}

- (void)initData {
 
    self.pickerLists = [NSMutableArray arrayWithObjects:@"1小时以后", @"2小时以后", @"3小时以后", @"4小时以后", @"5小时以后", nil];
}

- (void)initViews {
    
    [self setTitle:[NSString stringWithFormat:@"预定%@的服务", [self.orderInfo objectForKey:@"title"]]];
    
    [self initNavLeftBtn];
    [self initItemImgView];
    [self initPlaceNameView];
    [self initPlaceAddressView];
    [self initPickerView];
    [self initOrderBtnView];
}

- (void)initNavLeftBtn {
    
    self.leftNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftNavBtn.frame = CGRectMake(0, 0, iUnitPoint10 * 4, iUnitPoint10 * 4);
    [self.leftNavBtn setImage:[OnlineImage getIcon:@"ion-android-arrow-back" hexColor:e_textreversecolor size:30] forState:UIControlStateNormal];
    
    UIView *leftNavView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iScreenNavigationHeight, iScreenNavigationHeight)];
    [leftNavView addSubview:self.leftNavBtn];
    
    [self.leftNavBtn addTarget:self action:@selector(navPopViewClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftNavView];
    [self.navigationItem setLeftBarButtonItem:leftItem];
}

- (void)initItemImgView {
    
    NSString *imgStr;
    NSString *imgColor;
    
    for (HomeItem *item in [HomeItemFactory getItems]) {
        
        if ([item.title isEqualToString:[self.orderInfo objectForKey:@"title"]]) {
            
            imgStr = item.img;
            imgColor = item.bgColor;
        }
    }
    
    self.imgBgView = [[UIView alloc] init];
    self.imgBgView.backgroundColor = [UIColor colorWithHexString:imgColor];
    self.imgBgView.layer.cornerRadius = iUnitPoint10 * 12 / 2;
    self.imgBgView.clipsToBounds = YES;
    [self.view addSubview:self.imgBgView];
    
    [self.imgBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(iScreenNavigationHeight + iUnitPoint10 * 6);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(iUnitPoint10 * 12);
    }];
    
    self.imgView = [[UIImageView alloc] init];
    self.imgView.image = [UIImage imageNamed:imgStr];
    self.imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.imgBgView addSubview:self.imgView];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.centerY.mas_equalTo(self.imgBgView);
        make.size.mas_equalTo(iUnitPoint10 * 8);
    }];
}

- (void)initPlaceNameView {
    
    self.placeName = [[UILabel alloc] init];
    self.placeName.textAlignment = NSTextAlignmentCenter;
    self.placeName.font = [UIFont boldSystemFontOfSize:fontMiddle];
    self.placeName.textColor = [UIColor colorWithHexString:e_primaryblackcolor];
    self.placeName.text = [self.orderInfo objectForKey:@"placeName"];
    [self.view addSubview:self.placeName];
    
    [self.placeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgBgView.mas_bottom).mas_offset(iUnitPoint10 * 5);
        make.left.mas_equalTo(iUnitPoint10);
        make.right.mas_equalTo(-iUnitPoint10);
        make.height.mas_equalTo(iUnitPoint10 * 3);
    }];
    
}

- (void)initPlaceAddressView {
    
    self.placeAddress = [[UILabel alloc] init];
    self.placeAddress.textAlignment = NSTextAlignmentCenter;
    self.placeAddress.font = [UIFont boldSystemFontOfSize:fontMiddle];
    self.placeAddress.textColor = [UIColor colorWithHexString:e_primaryblackcolor];
    self.placeAddress.text = [self.orderInfo objectForKey:@"placeAddress"];
    [self.view addSubview:self.placeAddress];
    
    [self.placeAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.placeName.mas_bottom).mas_offset(iUnitPoint10);
        make.left.mas_equalTo(iUnitPoint10);
        make.right.mas_equalTo(-iUnitPoint10);
        make.height.mas_equalTo(iUnitPoint10 * 3);
    }];
}

- (void)initPickerView {
    
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.showsSelectionIndicator = YES;
    [self.view addSubview:self.pickerView];
    
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
       
    make.top.mas_equalTo(self.placeAddress.mas_bottom).mas_offset(iUnitPoint10 * 2);
        make.left.mas_equalTo(iUnitPoint10 * 6);
        make.right.mas_equalTo(-iUnitPoint10 * 6);
        make.height.mas_equalTo(iUnitPoint10 * 10);
    }];
    
}

- (void)initOrderBtnView {
    
    self.orderBtn = [[Button alloc] init];
    self.orderBtn.backgroundColor = [UIColor colorWithHexString:e_buttonnormalcolor];
    self.orderBtn.title = @"发送预约";
    self.orderBtn.titleColor = [UIColor colorWithHexString:e_textreversecolor];
    self.orderBtn.titleLabel.font = [UIFont systemFontOfSize:fontMiddle];
    self.orderBtn.layer.cornerRadius = 3;
    [self.view addSubview:self.orderBtn];

    [self.orderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-iUnitPoint10 * 5);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(iScreenWidth/2);
        make.height.mas_equalTo(iUnitPoint10 * 5);
    }];

    [self.orderBtn addTarget:self action:@selector(orderClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)orderClick {
    
    NSString *nickname = [EDUserStore get].nickname;
    NSString *carId = [EDUserStore get].carId;
    NSString *pickStr = emptyString;
    if (!self.pickerSelected) {
        pickStr = @"1小时以后";
    }
    
    NSString *msgBody = [NSString stringWithFormat:@"客户：%@，车牌号：%@，通过易行客户端进行了%@服务的预约，预约时间%@，收到消息后请做好服务的准备工作！", nickname, carId, [self.orderInfo objectForKey:@"title"], self.pickerSelected];
    [self showMessageView:[NSArray arrayWithObjects:[self.orderInfo objectForKey:@"tel"], nil] title:@"进行预约" body:msgBody];
}

# pragma mark - 向服务器提交预定请求
- (void)addOrderToServer {
    
    EDWebUserAddOrderRequest *addOrder = [[EDWebUserAddOrderRequest alloc] init];
    addOrder.userId = [EDUserStore get].userId;
    addOrder.uid = [self.orderInfo objectForKey:@"uid"];
    addOrder.placeName = [self.orderInfo objectForKey:@"placeName"];
    addOrder.placeAddress = [self.orderInfo objectForKey:@"placeAddress"];
    
    [self beginCicleProgressWithBg];
    [EDWebUserConnect addOrder:addOrder withFinished:^(id  _Nonnull response) {
        
        [self endProgress];

        EDWebBaseResponse *addReps = (EDWebBaseResponse *)response;
        
        if (addReps.isSuccess) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        [RKDropdownAlert title:addReps.msg time:2];
    }];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    switch (result) {
            
        case MessageComposeResultSent:
            //信息传送成功
            [self addOrderToServer];
            break;
            
        case MessageComposeResultFailed:
            //信息传送失败
            [self addOrderToServer];
            break;
            
        case MessageComposeResultCancelled:
            //信息被用户取消传送
            [self addOrderToServer];
            break;
            
        default:
            break;
    }
}

- (void)showMessageView:(NSArray *)phones title:(NSString *)title body:(NSString *)body {
    
    if( [MFMessageComposeViewController canSendText]) {
        
        MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
        controller.recipients = phones;
        controller.navigationBar.tintColor = [UIColor redColor];
        controller.body = body;
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:title];
        
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"该设备不支持短信功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [self.pickerLists count];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self.pickerSelected = [self.pickerLists objectAtIndex:row];

}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [self.pickerLists objectAtIndex:row];
}

- (void)navPopViewClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
