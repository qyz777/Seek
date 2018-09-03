//
//  MeViewController.m
//  Seek
//
//  Created by Q YiZhong on 2018/6/19.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "MeViewController.h"
#import "MeView.h"
#import "MeEditInfoViewController.h"
#import "YZLoginViewController.h"
#import "ZKSettingViewController.h"
#import "YZLikedViewController.h"

@interface MeViewController ()<MeViewDelegate>

@property (nonatomic, strong) MeView *meView;

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self initView];
    [self requestData];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ExLayerShouldBegin object:nil];
}

- (void)initView {
    self.view.backgroundColor = [UIColor whiteColor];
    [self navigationBar];
    self.yz_navigationBar.navigationBarColor = BACKGROUND_COLOR_STYLE_TWO;
    [self.yz_navigationBar addCenterTitleLabelWithTitle:@"我" font:[UIFont systemFontOfSize:18.0f weight:UIFontWeightBold] color:[UIColor whiteColor]];
    self.meView = [[MeView alloc]init];
    self.meView.yz_delegate = self;
    [self.view addSubview:self.meView];
}

- (void)requestData {
    
}

#pragma mark - MeViewDelegate
- (void)avatarImageDidSelect {
    MeEditInfoViewController *vc = [MeEditInfoViewController new];
    vc.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:vc animated:true];
}

- (void)rankCellDidSelect {
    
}

- (void)settingCellDidSelect {
    ZKSettingViewController *vc = [ZKSettingViewController new];
    vc.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:vc animated:true];
}

- (void)likeCellDidSelect {
    YZLikedViewController *vc = [YZLikedViewController new];
    vc.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:vc animated:true];
}

- (void)logOutBtnDidClicked {
    [User logOut];
    YZLoginViewController *vc = [YZLoginViewController new];
    [self presentViewController:vc animated:true completion:nil];
}

@end
