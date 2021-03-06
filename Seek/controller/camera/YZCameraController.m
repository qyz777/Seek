//
//  YZCameraController.m
//  Seek
//
//  Created by Q YiZhong on 2018/7/28.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZCameraController.h"
#import <AVFoundation/AVFoundation.h>
#import "YZTakePhotoView.h"
#import "YZCameraTransition.h"
#import "YZCameraQueryController.h"
#import "ZKGameSingleViewController.h"

@interface YZCameraController ()<
AVCapturePhotoCaptureDelegate,
YZTakePhotoViewDelegate,
UIGestureRecognizerDelegate,
UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureDeviceInput *input;
//照片输出流
@property (nonatomic, strong) AVCapturePhotoOutput *photoOutput;
//session：由他把输入输出结合在一起，并开始启动捕获设备（摄像头）
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

@property (nonatomic, strong) UIView *focusView;

@property (nonatomic, strong) UIButton *photoBtn;
@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, strong) YZTakePhotoView *takePhotoView;

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition * presentTransition;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition * dismissTransition;

@end

@implementation YZCameraController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self cameraConfig];
    [self initView];
    
    [self.photoBtn addTarget:self action:@selector(photoBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.closeBtn addTarget:self action:@selector(closeBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(focusTap:)];
    [self.view addGestureRecognizer:tap];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
}

- (void)initView {
    [self.view addSubview:self.closeBtn];
    [self.view addSubview:self.photoBtn];
    [self.view addSubview:self.takePhotoView];
    [self.view addSubview:self.focusView];
    
    [self.photoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-80);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(self.view).offset(20);
    }];
    
    [self.takePhotoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT));
    }];
}

- (void)cameraConfig {
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    if (self.input) {
        NSDictionary *settings = @{AVVideoCodecKey: AVVideoCodecJPEG};
        AVCapturePhotoSettings *outputSettings = [AVCapturePhotoSettings photoSettingsWithFormat:settings];
        self.photoOutput = [[AVCapturePhotoOutput alloc] init];
        [self.photoOutput setPhotoSettingsForSceneMonitoring:outputSettings];
        self.session = [[AVCaptureSession alloc]init];
        [self.session setSessionPreset:AVCaptureSessionPresetPhoto];
        [self.session addInput:self.input];
        [self.session addOutput:self.photoOutput];
        self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        self.previewLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self.view.layer insertSublayer:self.previewLayer atIndex:0];
        [self.session startRunning];
    }
}

- (void)focusTap:(UITapGestureRecognizer*)tap {
    if (!self.takePhotoView.isHidden) {
        return;
    }
    CGPoint tapPoint = [tap locationInView:tap.view];
    if ([self.device lockForConfiguration:nil]) {
        CGSize size = self.view.bounds.size;
        CGPoint focusPoint = CGPointMake(tapPoint.y / size.height, 1 - tapPoint.x / size.width);
//        聚集
        if ([self.device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
            [self.device setFocusPointOfInterest:focusPoint];
            [self.device setFocusMode:AVCaptureFocusModeAutoFocus];
        }
//        曝光
        if ([self.device isExposureModeSupported:AVCaptureExposureModeAutoExpose]) {
            [self.device setExposurePointOfInterest:focusPoint];
            [self.device setExposureMode:AVCaptureExposureModeAutoExpose];
        }
        
        [self.device unlockForConfiguration];
        self.focusView.center = tapPoint;
        self.focusView.hidden = NO;
        [UIView animateWithDuration:0.4 animations:^{
            self.focusView.transform = CGAffineTransformMakeScale(1.25, 1.25);
        }completion:^(BOOL finished) {
            self.focusView.transform = CGAffineTransformIdentity;
            self.focusView.hidden = YES;
        }];
    }
}

- (void)onPan:(UIPanGestureRecognizer *)pan {
    CGPoint velocity = [pan velocityInView:self.view];
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{
            if (velocity.x < 0) {
                self.dismissTransition = [UIPercentDrivenInteractiveTransition new];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
            break;
        case UIGestureRecognizerStateChanged:{
            CGPoint currentPoint = [pan translationInView:self.view];
            [self.dismissTransition updateInteractiveTransition:fabs(currentPoint.x) / self.view.width];
        }
            break;
        case UIGestureRecognizerStateEnded:{
            CGPoint currentPoint = [pan translationInView:self.view];
            if (fabs(currentPoint.x) / self.view.width > 0.35) {
                [self.dismissTransition finishInteractiveTransition];
            }else {
                [self.dismissTransition cancelInteractiveTransition];
            }
            self.dismissTransition = nil;
        }
            break;
        default:
            break;
    }
}

- (void)photoBtnDidClicked:(id)sender {
    NSDictionary *settings = @{AVVideoCodecKey: AVVideoCodecJPEG};
    AVCapturePhotoSettings *outputSettings = [AVCapturePhotoSettings photoSettingsWithFormat:settings];
    [self.photoOutput capturePhotoWithSettings:outputSettings delegate:self];
}

- (void)closeBtnDidClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(nonnull UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [YZCameraTransition new];
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.presentTransition;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [YZCameraTransition new];
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.dismissTransition;
}

#pragma mark - public
- (void)beginPresentTransition {
    self.presentTransition = [UIPercentDrivenInteractiveTransition new];
}

- (void)updatePresentTransition:(CGFloat)percent {
    [self.presentTransition updateInteractiveTransition:percent];
}

- (void)endPresentTransition:(CGFloat)percent {
    if (percent >= 0.35) {
        [self.presentTransition finishInteractiveTransition];
    }else {
        [self.presentTransition cancelInteractiveTransition];
    }
    self.presentTransition = nil;
}

#pragma mark - YZTakePhotoViewDelegate
- (void)okBtnDidClicked {
    self.takePhotoView.hidden = YES;
    self.photoBtn.hidden = NO;
    [self uploadImage];
}

- (void)cancelBtnDidClicked {
    self.takePhotoView.hidden = YES;
    self.photoBtn.hidden = NO;
}

#pragma mark - AVCapturePhotoCaptureDelegate
- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhotoSampleBuffer:(CMSampleBufferRef)photoSampleBuffer previewPhotoSampleBuffer:(CMSampleBufferRef)previewPhotoSampleBuffer resolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings bracketSettings:(AVCaptureBracketedStillImageSettings *)bracketSettings error:(NSError *)error {
    NSData *data = [AVCapturePhotoOutput JPEGPhotoDataRepresentationForJPEGSampleBuffer:photoSampleBuffer previewPhotoSampleBuffer:previewPhotoSampleBuffer];
    UIImage *image = [UIImage imageWithData:data];

    self.takePhotoView.imageData = image;
    self.takePhotoView.hidden = NO;
    [self.view bringSubviewToFront:self.takePhotoView];
    self.photoBtn.hidden = YES;
}

#pragma mark - private
- (void)uploadImage {
//    NSString *url = @"http://seek-api.xuzhengke.cn/index.php/Api/Util/upload";
    NSString *url = @"http://up.imgapi.com/";
    [SVProgressHUD show];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:url parameters:@{@"Token":@"93168e757658698195c41180399dadaae5c14bbd:7pNF1cr5ure9DqEn8vROCEQcEHI=:eyJkZWFkbGluZSI6MTUzNjQwNjQ1NSwiYWN0aW9uIjoiZ2V0IiwidWlkIjoiNDA3MyIsImFpZCI6IjgwMTIiLCJmcm9tIjoiZmlsZSJ9"} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImageJPEGRepresentation(self.takePhotoView.imageData, 0.5);
        NSDate *date = [NSDate date];
        NSDateFormatter *formormat = [[NSDateFormatter alloc]init];
        [formormat setDateFormat:@"YYYYHHmmss"];
        NSString *dateString = [formormat stringFromDate:date];
        NSString *fileName = [NSString  stringWithFormat:@"%@_%ld.jpeg",dateString, [User sharedUser].userId];
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *json = responseObject;
        YZLog(@"%@",json);
        
        NSInteger code = [json[@"width"] integerValue];
        if (code > 0) {
            if (json[@"linkurl"]) {
//                NSString *imageUrl = [NSString stringWithFormat:@"http://seek-api.xuzhengke.cn/Uploads/%@",json[@"linkurl"]];
                NSString *imageUrl = json[@"linkurl"];
                [self requestWordWithImageUrl:imageUrl];
            }
        }else {
            [SVProgressHUD dismiss];
            [SVProgressHUD showInfoWithStatus:@"上传失败"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showInfoWithStatus:@"上传失败"];
        YZLog(@"error: %@",error);
    }];
}

- (void)requestWordWithImageUrl:(NSString *)imageUrl {
    NSString *url = @"http://seek-api.xuzhengke.cn/index.php/Api/Util/ocr";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 60.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manager POST:url parameters:@{@"img": imageUrl} progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        NSDictionary *json = responseObject;
        YZLog(@"%@",json);
        NSInteger code = [json[@"code"] integerValue];
        if (code == 0) {
            NSDictionary *data = json[@"data"];
            NSArray *list = data[@"list"];
            if (list.count == 0) {
                [SVProgressHUD showInfoWithStatus:@"图片没有提取出单词哦"];
            }else {
                if (self.isQuery) {
                    [self handleQueryData:list];
                }else {
                    ZKGameSingleViewController *vc = [ZKGameSingleViewController new];
                    vc.isFromCamera = YES;
                    vc.resArray = list.mutableCopy;
                    [self presentViewController:vc animated:YES completion:nil];
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showInfoWithStatus:@"请求失败"];
        
        YZLog(@"%@",error);
    }];
}

- (void)handleQueryData:(NSArray *)data {
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *d in data) {
        NSDictionary *sD = @{@"entry": d[@"question"][0], @"explain": @""};
        [array addObject:sD];
    }
    YZCameraQueryController *vc = [YZCameraQueryController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.dataArray = array;
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - getter
- (UIButton *)photoBtn {
    if (!_photoBtn) {
        _photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _photoBtn.layer.cornerRadius = 40;
        _photoBtn.backgroundColor = UIColorFromRGB(0xfa3e54);
    }
    return _photoBtn;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    }
    return _closeBtn;
}

- (UIView *)focusView {
    if (!_focusView) {
        _focusView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        _focusView.layer.borderColor = UIColorFromRGB(0xf9cf34).CGColor;
        _focusView.layer.borderWidth = 2.0f;
        _focusView.backgroundColor = [UIColor clearColor];
        _focusView.hidden = YES;
    }
    return _focusView;
}

- (YZTakePhotoView *)takePhotoView {
    if (!_takePhotoView) {
        _takePhotoView = [[YZTakePhotoView alloc] init];
        _takePhotoView.yz_delegate = self;
        _takePhotoView.hidden = YES;
    }
    return _takePhotoView;
}


@end
