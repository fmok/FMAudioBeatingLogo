//
//  JMAudioManager.h
//  FMAudioBeatingLogo
//
//  Created by fm on 2017/3/23.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMAudioManager : NSObject

@property (nonatomic, assign) BOOL isPlay;  // 是否正在播放
+ (instancetype)shareInfo;

@end
