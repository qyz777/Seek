//
//  WebSocketManager.m
//  Seek
//
//  Created by Q YiZhong on 2018/9/14.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "WebSocketManager.h"

static NSString * SOCKET_URL = @"ws://123.207.161.121:7272";

@interface WebSocketManager ()<SRWebSocketDelegate>

@property (nonatomic, strong) dispatch_queue_t socketQueue;

@end


@implementation WebSocketManager

+ (void)initialize {
    [self manager];
}

static WebSocketManager * manager;
+ (instancetype)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [[WebSocketManager alloc] init];
            manager.socketQueue = dispatch_queue_create("socketQueue", DISPATCH_QUEUE_SERIAL);
        }
    });
    return manager;
}

- (void)startMatching {
    self.socket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:SOCKET_URL]]];
    self.socket.delegate = self;
    [self.socket open];
}

- (void)stop {
    [self.socket close];
    self.socket = nil;
}

#pragma mark - SRWebSocketDelegate
// 连接成功
- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    YZLog(@"websocket连接成功");
    //登录
    User *user = [User sharedUser];
    NSString *data = [NSString stringWithFormat:@"{\"type\":\"login\",\"uid\":\"%ld\",\"nickname\":\"%@\",\"headimg\":\"\"}",user.userId,user.nickName];
    [self sendData:data];
    
    //开始匹配
    data = [NSString stringWithFormat:@"{\"type\":\"start_game\",\"uid\":\"%ld\",\"conditions_id\":\"1\"}",user.userId];
    [self sendData:data];
}

// 连接失败
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    [SVProgressHUD showErrorWithStatus:@"匹配失败,请检查网络设置"];
    YZLog(@"%@",error.localizedDescription);
}

// 收到消息通知
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    YZLog(@"收到消息了");
    NSData *jsonData = [message dataUsingEncoding:NSUTF8StringEncoding];
    
    YZLog(@"%@",message);
    NSError *err = nil;
    
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&err];
    
    if (err) {
        if ([self.socket_delegate respondsToSelector:@selector(matchingError)]) {
            [self.socket_delegate matchingError];
        }
    }else{
        if ([data[@"type"] isEqualToString:@"ping"] ) {
            //回应
            YZLog(@"回应连接");
            NSString *sendStr = @"{\"type\": \"pong\"}";
            [self sendData:sendStr];
        }else{
            switch ([data[@"code"] integerValue]) {
                case 5:
                    //等待开始
                    break;
                case 6:
                    //匹配成功 即将开始
                    if ([self.socket_delegate respondsToSelector:@selector(gameShouldBeginWithData:)]) {
                        [self.socket_delegate gameShouldBeginWithData:data];
                    }
                    break;
                case 8:
                    //开始答题
//                    if ([self.socket_delegate respondsToSelector:@selector(refreshQuestionWithData:)]) {
//                        [self.socket_delegate refreshQuestionWithData:data[@"data"][@"question"]];
//                    }
                    break;
                case 12:
                    //答题结果
                    if ([self.socket_delegate respondsToSelector:@selector(questionAnswerWithData:)]) {
                        [self.socket_delegate questionAnswerWithData:data[@"data"]];
                    }
                    break;
                case 9:
                    //答题结束
                    YZLog(@"答题结束");
                    if ([self.socket_delegate respondsToSelector:@selector(finishWithData:)]) {
                        [self.socket_delegate finishWithData:data];
                    }
                    break;
                    
                case 10:
                    // 对方退出
                    if ([self.socket_delegate respondsToSelector:@selector(otherDidLogout)]) {
                        [self.socket_delegate otherDidLogout];
                    }
                    break;
                    
                default:
                    break;
            }
        }
    }
}

- (void)sendData:(id)data {
    dispatch_async(self.socketQueue, ^{
        if (self.socket) {
            // 只有 SR_OPEN 开启状态才能调 send 方法啊，不然要崩
            if (self.socket.readyState == SR_OPEN) {
                [self.socket send:data];    // 发送数据
                YZLog(@"发送消息:%@",data);
            } else if (self.socket.readyState == SR_CONNECTING) {
                YZLog(@"正在连接中，重连后其他方法会去自动同步数据");
                // 每隔2秒检测一次 socket.readyState 状态，检测 10 次左右
                // 只要有一次状态是 SR_OPEN 的就调用 [ws.socket send:data] 发送数据
                // 如果 10 次都还是没连上的，那这个发送请求就丢失了，这种情况是服务器的问题了，小概率的
                // 代码有点长，我就写个逻辑在这里好了
                
            } else if (self.socket.readyState == SR_CLOSING || self.socket.readyState == SR_CLOSED) {
                // websocket 断开了，调用 reConnect 方法重连
                YZLog(@"socket断开了");
            }
        } else {
            if ([self.socket_delegate respondsToSelector:@selector(matchingError)]) {
                [self.socket_delegate matchingError];
            }
        }
    });
}

@end
