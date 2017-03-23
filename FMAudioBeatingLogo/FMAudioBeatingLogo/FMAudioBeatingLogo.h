//
//  FMAudioBeatingLogo.h
//  FMAudioBeatingLogo
//
//  Created by fm on 2017/3/23.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import <UIKit/UIKit.h>

// 音频播放状态发生改变时，发送此通知
#define audioSignStyleChange @"audioSignStyleChange"
// 16进制数转换成color值
#define SRGBCOLOR_HEX(hex) SRGBCOLOR(((hex & 0xFF0000 )>>16), ((hex & 0x00FF00 )>>8), (hex & 0x0000FF))
#define SRGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

typedef NS_ENUM(NSInteger, JMAudioSignStyle) {
    JMAudioSignStyleJump = 10,
    JMAudioSignStyleStop
};

@protocol FMAudioBeatingLogoDelegate <NSObject>

- (void)clickAudioLogoAction;

@end

@interface FMAudioBeatingLogo : UIControl

@property (nonatomic, weak) id<FMAudioBeatingLogoDelegate>delegate;
@property (nonatomic, assign) BOOL isNeedHiddenWhenStop;  // 停止播放音频时，是否需要隐藏音频标识

@property (nonatomic, strong) NSMutableArray *layers;

// 根据读取本地的音频信息，判断app的音频标识显隐，以及跳动与否
- (void)fixAudioLogoShowAndPlayingState;
// 音频标识 显隐 及 跳动与否 （仅用于 【专辑列表】页）
//- (void)isShowAudioLogo;
// 显示音频标识  （仅用于【音频首页】，在列表中直接单挑音频的情况）
- (void)showAudioLogo;

@end
