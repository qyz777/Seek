//
//  YZTakePhotoView.h
//  Seek
//
//  Created by Q YiZhong on 2018/7/28.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YZTakePhotoViewDelegate <NSObject>

- (void)okBtnDidClicked;
- (void)cancelBtnDidClicked;

@end

@interface YZTakePhotoView : UIView

@property (nonatomic, strong) UIButton *okBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIImage *imageData;

@property (nonatomic, weak) id<YZTakePhotoViewDelegate> yz_delegate;

@end
