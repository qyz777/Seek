
//
//  YZSearchViewController.m
//  Seek
//
//  Created by Q YiZhong on 2018/5/8.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZSearchViewController.h"
#import "YZSearchTableView.h"
#import "SearchAnimation.h"
#import "UIViewController+YZNavigationBar.h"

NSNotificationName const SearchFieldDidChangeNotification = @"SearchFieldDidChangeNotification";

@interface YZSearchViewController ()<UIViewControllerTransitioningDelegate>

@property(nonatomic, strong)YZSearchTableView *searchView;
@property(nonatomic, strong)UITextField *searchField;

@end

@implementation YZSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.transitioningDelegate = self;
    self.modalPresentationStyle = UIModalPresentationCustom;
    [self initView];
    Add_Observer(SearchTableViewDidScrollNotification, self, searchTableViewDidScroll, nil);
}

- (void)dealloc {
    Remove_Observer(self);
}

- (void)initView {
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *backgroundView = [[UIView alloc]initWithFrame:self.view.bounds];
    backgroundView.backgroundColor = BACKGROUND_COLOR_STYLE_ONE;
    [self.view addSubview:backgroundView];
    self.searchView = [[YZSearchTableView alloc]init];
    [backgroundView addSubview:self.searchView];
    [self navigationBar];
    self.yz_navigationBar.navigationBarColor = RGB_ALPHA(0, 0, 0, 0.3);
    UIButton *leftBtn = [self.yz_navigationBar addLeftButtonWithImage:[UIImage imageNamed:@"搜索"]];
    [leftBtn addTarget:self action:@selector(clickLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *rightBtn = [self.yz_navigationBar addRightButtonWithTitle:@"取消"
                                                                   font:[UIFont boldSystemFontOfSize:20.0f]
                                                                  color:[UIColor whiteColor]];
    [rightBtn addTarget:self action:@selector(clickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.searchField = [UITextField new];
    self.searchField.backgroundColor = [UIColor whiteColor];
    self.searchField.layer.cornerRadius = 12.0f;
    self.searchField.placeholder = @"请输入需要搜索的单词";
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    self.searchField.leftViewMode = UITextFieldViewModeAlways;
    self.searchField.leftView = leftView;
    [self.searchField addTarget:self action:@selector(searchFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.yz_navigationBar addSubview:self.searchField];
    [self.searchField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftBtn.mas_right).offset(10);
        make.right.equalTo(rightBtn.mas_left).offset(-20);
        make.height.mas_equalTo(30);
        make.centerY.equalTo(leftBtn);
    }];
}

- (void)clickLeftBtn:(id)sender {
    
}

- (void)clickRightBtn:(id)sender {
    [self dismissViewControllerAnimated:true completion:^{
        
    }];
}

- (void)searchFieldDidChange:(UITextField *)textField {
//    TODO 发起网络请求
    
}

- (void)searchTableViewDidScroll {
    [self.searchField resignFirstResponder];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [[SearchAnimation alloc]init];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [[SearchAnimation alloc]init];
}

@end
