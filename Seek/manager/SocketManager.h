//
//  SocketManager.h
//  Seek
//
//  Created by Q YiZhong on 2018/7/9.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//
//  开启了子线程用于接收消息，所有的代理都不在主线程，所以代理回调需要回到主线程
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SocketConnectStatus) {
    SocketConnectStatus_UnConnected = 0,
    SocketConnectStatus_Connected,
    SocketConnectStatus_Unknow
};

@protocol SocketManagerDelegate <NSObject>

- (void)didReceiveMessage:(NSString *)msg;

@end

@interface SocketManager : NSObject

@property (nonatomic, assign) SocketConnectStatus connectStatus;

@property (nonatomic, weak) id<SocketManagerDelegate> connect_delegate;

+ (instancetype)sharedSocketManager;

// 连接
- (BOOL)connect;
// 断开连接
- (void)disConnect;

- (void)sendMessage:(NSString *)message;

@end
