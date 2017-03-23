//
//  JMAudioManager.m
//  FMAudioBeatingLogo
//
//  Created by fm on 2017/3/23.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "FMAudioManager.h"

static FMAudioManager *_audioManager = nil;

@implementation FMAudioManager

+ (instancetype)shareInfo
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _audioManager = [[FMAudioManager alloc] init];
    });
    return _audioManager;
}

@end
