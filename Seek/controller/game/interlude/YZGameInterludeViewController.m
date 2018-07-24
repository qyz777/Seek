//
//  YZGameInterludeViewController.m
//  Seek
//
//  Created by Q YiZhong on 2018/7/10.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZGameInterludeViewController.h"
#import "YZGameInterludeFindView.h"
#import "User.h"
#import <SocketRocket.h>
#import <SVProgressHUD.h>

@interface YZGameInterludeViewController ()<SRWebSocketDelegate>

@property (nonatomic, strong) YZGameInterludeFindView *findBackView;
@property (nonatomic, strong) UIView *findTopView;
@property (nonatomic, strong) UILabel *findLabel;
@property (nonatomic, strong) UIButton *quitBtn;

// webSocket
@property (nonatomic, strong) SRWebSocket *socket;
@property (nonatomic,strong)dispatch_queue_t socketQueue;

@end

@implementation YZGameInterludeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    
    [self.quitBtn addTarget:self action:@selector(quitBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //开始真正匹配游戏
    [self matchingStart];
}

- (void)initView {
    CAGradientLayer *backLayer = [CAGradientLayer layer];
    backLayer.frame = self.view.bounds;
    [backLayer setColors:@[(id)[UIColorFromRGB(0x703691) CGColor], (id)[UIColorFromRGB(0xaa66d1) CGColor]]];
    [backLayer setLocations:@[@0.5, @1.0]];
    [backLayer setStartPoint:CGPointMake(0, 0)];
    [backLayer setEndPoint:CGPointMake(0.4, 1)];
    [self.view.layer addSublayer:backLayer];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    effectView.frame = self.view.frame;
    [self.view addSubview:effectView];
    
    [self.view addSubview:self.findBackView];
    [self.view addSubview:self.findTopView];
    [self.findTopView addSubview:self.findLabel];
    [self.view addSubview:self.quitBtn];
    
    [self.findBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(150);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(180, 180));
    }];
    
    [self.findTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(150);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(180, 180));
    }];
    
    [self.findLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.findTopView);
    }];
    
    [self.quitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-70);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(180, 44));
    }];
}

- (void)quitBtnDidClicked:(id)sender {
    // 先关闭链接
    [self.socket close];
    
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - getter
- (YZGameInterludeFindView *)findBackView {
    if (!_findBackView) {
        _findBackView = [[YZGameInterludeFindView alloc]init];
    }
    return _findBackView;
}

- (UIView *)findTopView {
    if (!_findTopView) {
        _findTopView = [UIView new];
        _findTopView.backgroundColor = [UIColor whiteColor];
        _findTopView.layer.cornerRadius = 90;
    }
    return _findTopView;
}

- (UILabel *)findLabel {
    if (!_findLabel) {
        _findLabel = [UILabel new];
        _findLabel.text = @"匹配中...";
        _findLabel.textColor = UIColorFromRGB(0x703691);
        _findLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    }
    return _findLabel;
}

- (UIButton *)quitBtn {
    if (!_quitBtn) {
        _quitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _quitBtn.layer.cornerRadius = 20.0f;
        _quitBtn.backgroundColor = [UIColor whiteColor];
        [_quitBtn setTitleColor:UIColorFromRGB(0x703691) forState:UIControlStateNormal];
        _quitBtn.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
        [_quitBtn setTitle:@"取消匹配" forState:UIControlStateNormal];
    }
    return _quitBtn;
}

/**
 * ZK 集成WebSocket 对战功能
 */
- (void)matchingStart {
    //初始化消息队列(串行)
    self.socketQueue = dispatch_queue_create("socketQueue", DISPATCH_QUEUE_SERIAL);
    
    self.socket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://123.207.161.121:7272"]]];
    _socket.delegate = self;
    
    //连接
    [_socket open];
}

/**
 * WebSocket 回调方法
 */

// 连接成功
- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    NSLog(@"websocket连接成功");
    
    //登录
    NSInteger userID = [User sharedUser].userId;
    userID = 99789;
    NSString *data = [NSString stringWithFormat:@"{\"type\":\"login\",\"uid\":\"%ld\"}",userID];
    [self sendData:data];
    
    //开始匹配
    data = [NSString stringWithFormat:@"{\"type\":\"start_game\",\"uid\":\"%ld\",\"conditions_id\":\"1\"}",userID];
    [self sendData:data];
}

// 连接失败
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    [SVProgressHUD showErrorWithStatus:@"匹配失败,请检查网络设置"];
    NSLog(@"%@",error.localizedDescription);
}

// 收到消息通知
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSLog(@"收到消息了");
    NSData *jsonData = [message dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",message);
    NSError *err = nil;
    
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&err];
    
    if (err) {
        [SVProgressHUD showErrorWithStatus:@"服务器出错,请重新匹配"];
    }else{
        if ([data[@"type"] isEqualToString:@"ping"] ) {
            //回应
            NSLog(@"回应连接");
            NSString *sendStr = @"{\"type\": \"pong\"}";
            [self sendData:sendStr];
        }else{
            switch ([data[@"code"] integerValue]) {
                case 5:
                    //等待开始
                    break;
                case 6:
                    //匹配成功 即将开始
                    break;
                case 8:
                    //开始答题
                    break;
                case 12:
                    //答题结果
                    break;
                case 9:
                    //答题结束
                    break;
                    
                case 10:
                    // 对方退出
                    [SVProgressHUD showErrorWithStatus:@"对方已经退出游戏"];
                    break;
                    
                default:
                    break;
            }
        }
    }
}

- (void)sendData:(id)data {
    __weak typeof(self) weakSelf = self;
    dispatch_async(self.socketQueue, ^{
        if (weakSelf.socket != nil) {
            // 只有 SR_OPEN 开启状态才能调 send 方法啊，不然要崩
            if (weakSelf.socket.readyState == SR_OPEN) {
                [weakSelf.socket send:data];    // 发送数据
                NSLog(@"发送消息:%@",data);
            } else if (weakSelf.socket.readyState == SR_CONNECTING) {
                NSLog(@"正在连接中，重连后其他方法会去自动同步数据");
                // 每隔2秒检测一次 socket.readyState 状态，检测 10 次左右
                // 只要有一次状态是 SR_OPEN 的就调用 [ws.socket send:data] 发送数据
                // 如果 10 次都还是没连上的，那这个发送请求就丢失了，这种情况是服务器的问题了，小概率的
                // 代码有点长，我就写个逻辑在这里好了
                
            } else if (weakSelf.socket.readyState == SR_CLOSING || weakSelf.socket.readyState == SR_CLOSED) {
                // websocket 断开了，调用 reConnect 方法重连
                NSLog(@"socket断开了");
            }
        } else {
            [SVProgressHUD showErrorWithStatus:@"请检查网络设置"];
        }
    });
}

@end
