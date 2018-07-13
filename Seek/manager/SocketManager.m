//
//  SocketManager.m
//  Seek
//
//  Created by Q YiZhong on 2018/7/9.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "SocketManager.h"
#import "GCDAsyncSocket.h"

// 自动连接次数
#define TCP_AutoConnectCount 3
// 心跳间隔
#define TCP_BeatDuration 1.0
// 最大心跳次数
#define TCP_MaxBeatMissCount 3
// 心跳标识
#define TCP_BeatIdentity @"beat"
// 服务器
#define HOST @"127.0.0.1"
// 端口
#define PORT 9999
// 连接标签
#define CONNECT_TAG 999

@interface SocketManager ()<GCDAsyncSocketDelegate>

@property (nonatomic, strong) GCDAsyncSocket *socket;
// 心跳计时器
@property (nonatomic, strong) dispatch_source_t beatTimer;
// 自动重连次数
@property (nonatomic, assign) NSInteger autoConnectCount;
@property (nonatomic, assign) NSInteger beatCount;

@end

@implementation SocketManager

static SocketManager *socketManager;
+ (instancetype)sharedSocketManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!socketManager) {
            socketManager = [[SocketManager alloc]init];
        }
    });
    return socketManager;
}

+ (void)initialize {
    [self sharedSocketManager];
}

+ (instancetype)alloc {
    if (socketManager) {
        NSException *exception = [NSException exceptionWithName:@"error" reason:@"分配了多余的内存" userInfo:nil];
        [exception raise];
    }
    return [super alloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.socket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
    }
    return self;
}

#pragma mark - public
- (BOOL)connect {
    return [self.socket connectToHost:HOST onPort:PORT error:nil];
}

- (void)disConnect {
    [self.socket disconnect];
}

- (void)sendMessage:(NSString *)message {
    if (self.connectStatus == SocketConnectStatus_UnConnected) {
        [self connect];
    }
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    [self.socket writeData:data withTimeout:-1 tag:CONNECT_TAG];
}

#pragma mark - private
- (void)pullMessage {
    [self.socket readDataWithTimeout:-1 tag:CONNECT_TAG];
}

#pragma mark - GCDAsyncSocketDelegate
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    NSLog(@"连接成功,host:%@,port:%d",host,port);
    self.connectStatus = SocketConnectStatus_Connected;
    self.autoConnectCount = 3;
    [self pullMessage];
    dispatch_resume(self.beatTimer);
    
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    self.connectStatus = SocketConnectStatus_UnConnected;
    dispatch_source_cancel(self.beatTimer);
    self.beatCount = 0;
    self.autoConnectCount = TCP_AutoConnectCount;
    if (err) {
        [self connect];
    }else {
        NSLog(@"正常断开");
    }
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    NSString *msg = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"收到消息：%@",msg);
    [self pullMessage];
    //    TODO:处理数据，如果是心跳把beatCount置为0
    if ([msg isEqualToString:TCP_BeatIdentity]) {
        self.beatCount = 0;
    }else {
        if ([self.connect_delegate respondsToSelector:@selector(didReceiveMessage:)]) {
            [self.connect_delegate didReceiveMessage:msg];
        }
    }
}

#pragma mark - getter
- (dispatch_source_t)beatTimer {
    if (!_beatTimer) {
        _beatTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
        dispatch_source_set_timer(_beatTimer, DISPATCH_TIME_NOW, TCP_BeatDuration * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        YZWeakObject(self);
        dispatch_source_set_event_handler(_beatTimer, ^{
            //发送心跳 +1
            weakself.beatCount++;
            //超过3次未收到服务器心跳 , 置为未连接状态
            if (weakself.beatCount > TCP_MaxBeatMissCount) {
                //更新连接状态
                weakself.connectStatus = SocketConnectStatus_UnConnected;
            }else {
                //发送心跳
                [weakself sendMessage:TCP_BeatIdentity];
            }
        });
    }
    return _beatTimer;
}

@end
