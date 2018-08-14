//
//  ZKStartViewController.m
//  Seek
//
//  Created by 徐正科 on 2018/8/14.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "ZKStartViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "YZLoginViewController.h"

@interface ZKStartViewController ()

// 播放器
@property(nonatomic,strong)AVPlayerViewController *AVPlayer;

@end

@implementation ZKStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.blackColor;
    
    self.url = [[NSBundle mainBundle] pathForResource:@"seek_start" ofType:@"m4v"];
    
    // 初始化AVPlayer
    [self setPlayer];
}

- (void)setPlayer {
    self.AVPlayer = [[AVPlayerViewController alloc] init];
    
    // 取消多分屏
    _AVPlayer.allowsPictureInPicturePlayback = NO;
    // 取消多媒体播放组件
    _AVPlayer.showsPlaybackControls = NO;
    
    AVPlayerItem *item =[[AVPlayerItem alloc] initWithURL:[NSURL fileURLWithPath:_url]];
    
    AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
    
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
    [layer setFrame:[UIScreen mainScreen].bounds];
    // 设置视频填充模式
    layer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    self.AVPlayer.player = player;
    
    // 添加到视图
    [self.view.layer addSublayer:layer];
    
    // 播放
    [self.AVPlayer.player play];
    
    // 延迟两秒进入控制器
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(finishPlay) userInfo:nil repeats:NO];
}

// 完成播放
- (void)finishPlay {
    if (self.vc == nil) {
        self.vc = [[YZLoginViewController alloc] init];
    }
    
    self.view.window.rootViewController = _vc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
