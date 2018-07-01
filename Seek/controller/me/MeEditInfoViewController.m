//
//  MeEditInfoViewController.m
//  Seek
//
//  Created by Q YiZhong on 2018/7/1.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "MeEditInfoViewController.h"

@interface MeEditInfoViewController ()

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UITextField *nameTextField;

@end

@implementation MeEditInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    UIButton *completeBtn = [self.yz_navigationBar addRightButtonWithTitle:@"完成" font:[UIFont systemFontOfSize:15.0f] color:[UIColor whiteColor]];
    [completeBtn addTarget:self action:@selector(completeBtnDidCliked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.yz_navigationBar addCenterTitleLabelWithTitle:@"编辑" font:[UIFont systemFontOfSize:20.0f weight:UIFontWeightBold] color:[UIColor whiteColor]];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, NavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarHeight)];
    backView.backgroundColor = BACKGROUND_COLOR_STYLE_TWO;
    [self.view addSubview:backView];
    
    [backView addSubview:self.avatarImageView];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(30);
        make.centerX.equalTo(backView);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    [backView addSubview:self.nameTextField];
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarImageView.mas_bottom).offset(30);
        make.centerX.equalTo(backView);
        make.left.equalTo(backView).offset(30);
        make.right.equalTo(backView).offset(-30);
        make.height.mas_equalTo(38);
    }];
}

- (void)completeBtnDidCliked:(id)sender {
    //    TODO:qyz 编辑
    [self.navigationController popViewControllerAnimated:true];
}

- (void)setDataDict:(NSDictionary *)dataDict {
    _dataDict = dataDict;
    //    TODO:qyz数据
}

#pragma mark - getter
- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [UIImageView new];
        _avatarImageView.layer.cornerRadius = 40.0f;
        _avatarImageView.layer.masksToBounds = true;
        _avatarImageView.image = [UIImage imageNamed:@"default_icon"];
    }
    return _avatarImageView;
}

- (UITextField *)nameTextField {
    if (!_nameTextField) {
        _nameTextField = [UITextField new];
        _nameTextField.backgroundColor = [UIColor whiteColor];
        UIView *leftView = [UIView new];
        leftView.frame = CGRectMake(0, 0, 10, 0);
        _nameTextField.leftView = leftView;
        _nameTextField.leftViewMode = UITextFieldViewModeAlways;
        _nameTextField.layer.cornerRadius = 12.0f;
    }
    return _nameTextField;
}

@end
