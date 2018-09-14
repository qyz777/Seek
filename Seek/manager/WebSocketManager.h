//
//  WebSocketManager.h
//  Seek
//
//  Created by Q YiZhong on 2018/9/14.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SRWebSocket.h>

@protocol WebSocketManagerDelegate <NSObject>

@optional
// 匹配成功 即将开始
- (void)gameShouldBeginWithData:(NSDictionary *)data;
// 刷新题目
- (void)refreshQuestionWithData:(NSDictionary *)data;
// 答题结果
- (void)questionAnswerWithData:(NSDictionary *)data;
// 答题结束
- (void)finishWithData:(NSDictionary *)data;
// 对手退出
- (void)otherDidLogout;
// 出错
- (void)matchingError;

@end

@interface WebSocketManager : NSObject

@property (nonatomic, strong) SRWebSocket *socket;

@property (nonatomic, weak) id<WebSocketManagerDelegate> socket_delegate;

- (void)startMatching;

- (void)stop;

- (void)sendData:(id)data;

+ (instancetype)manager;

@end
