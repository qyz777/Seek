
//
//  YZSearchViewController.m
//  Seek
//
//  Created by Q YiZhong on 2018/5/8.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZSearchViewController.h"
#import "YZSearchTableView.h"
#import "UIViewController+YZNavigationBar.h"
#import "YZWord.h"
#import "YZHistoryWord.h"
#import "YZWordDetailViewController.h"

NSNotificationName const SearchFieldDidChangeNotification = @"SearchFieldDidChangeNotification";

@interface YZSearchViewController ()<UITextFieldDelegate,YZSearchTableViewDelegate>

@property(nonatomic, strong)YZSearchTableView *searchView;
@property(nonatomic, strong)UITextField *searchField;

@end

@implementation YZSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundView];
    self.searchView = [[YZSearchTableView alloc]init];
    self.searchView.yz_delegate = self;
    self.searchView.historyDataArray = [YZHistoryWord arrayFromSearchHistory];
    if (!self.searchView.historyDataArray) {
        self.searchView.historyDataArray = @[].mutableCopy;
    }
    [backgroundView addSubview:self.searchView];
    [self navigationBar];
    self.yz_navigationBar.navigationBarColor = BACKGROUND_COLOR_STYLE_TWO;
    UIButton *leftBtn = [self.yz_navigationBar addLeftButtonWithImage:[UIImage imageNamed:@"main_search_btn"]];
    [leftBtn addTarget:self action:@selector(clickLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *rightBtn = [self.yz_navigationBar addRightButtonWithTitle:@"取消"
                                                                   font:[UIFont boldSystemFontOfSize:20.0f]
                                                                  color:[UIColor whiteColor]];
    [rightBtn addTarget:self action:@selector(clickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.searchField = [UITextField new];
    self.searchField.delegate = self;
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
    [self.navigationController popViewControllerAnimated:true];
}

#pragma mark - yz_delegate
- (void)cellDidSelectWithDict:(NSDictionary *)dict {
    YZWordDetailViewController *vc = [YZWordDetailViewController new];
    vc.word = dict[@"entry"];
    [self.navigationController pushViewController:vc animated:true];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [YZHistoryWord removeAllSearchHistory];
        [YZHistoryWord searchHistoryCacheWithArray:self.searchView.historyDataArray.mutableCopy];
    });
}

- (void)clearSearchHistoryBtnDidTouchUpInside {
    self.searchView.clearHistoryBtn.hidden = true;
    [self.searchView.historyDataArray removeAllObjects];
    [self.searchView reloadData];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [YZHistoryWord removeAllSearchHistory];
    });
}

- (void)searchFieldDidChange:(UITextField *)textField {
    [YZWord searchWordWithString:textField.text success:^(NSArray<NSDictionary *> *dataArray) {
        self.searchView.dataArray = dataArray;
        [self.searchView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)searchTableViewDidScroll {
    [self.searchField resignFirstResponder];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.searchField resignFirstResponder];
    return true;
}

@end
