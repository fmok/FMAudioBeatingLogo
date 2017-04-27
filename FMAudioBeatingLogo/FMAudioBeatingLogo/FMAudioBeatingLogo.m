//
//  FMAudioBeatingLogo.m
//  FMAudioBeatingLogo
//
//  Created by fm on 2017/3/23.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "FMAudioBeatingLogo.h"
#import "FMAudioManager.h"

#define kJMBeatingAudio 0.33
#define kJMBeatingAudioKey @"beatingAudioKey"

@interface FMAudioBeatingLogo()

@end

@implementation FMAudioBeatingLogo

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:audioSignStyleChange object:nil];
}

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layers = [NSMutableArray array];
        [self configureUI];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioSignStyleAction:) name:audioSignStyleChange object:nil];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAudioLogo:)];
        tap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tap];
    }
    return self;
}

#pragma mark - NotificationCenter
- (void)audioSignStyleAction:(NSNotification *)notifi
{
    if ([[notifi.userInfo objectForKey:@"style"] integerValue] == JMAudioSignStyleJump) {
        if (self.isNeedHiddenWhenStop) {
            [self showAudioLogo];
        } else {
            [self startAnimation];
        }
    } else if ([[notifi.userInfo objectForKey:@"style"] integerValue] == JMAudioSignStyleStop) {
        if (self.isNeedHiddenWhenStop) {
            [self hiddenAudioLogo];
        } else {
            [self stopAnimation];
        }
    }
}

#pragma mark - Event
- (void)tapAudioLogo:(UITapGestureRecognizer *)tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickAudioLogoAction)]) {
        [self.delegate clickAudioLogoAction];
    }
}

#pragma mark - Piblic methods
//- (void)isShowAudioLogo
//{
//    if ([JMAudioManager shareInfo].isPlay) {
//        [self showAudioLogo];
//    } else {
//        [self hiddenAudioLogo];
//    }
//}

- (void)fixAudioLogoShowAndPlayingState
{
    [self showAudioLogo];
//    if ([FMThumbUpManager thumbAudioInfo]) {
//        [self showAudioLogo];
//    } else {
//        [self hiddenAudioLogo];
//    }
}

- (void)showAudioLogo
{
    self.hidden = NO;
    [self isAudioPlay];
}

#pragma mark - Private methods
- (void)hiddenAudioLogo
{
    self.hidden = YES;
    [self isAudioPlay];
}

- (void)isAudioPlay
{
    if ([FMAudioManager shareInfo].isPlay) {
        [self startAnimation];
    } else {
        [self stopAnimation];
    }
}

- (void)startAnimation {
    if (self.layers.count <= 0) {
        return;
    }
    [self animationB];
}

- (void)stopAnimation
{
    if (self.layers.count <= 0) {
        return;
    }
    for (int i=0; i<4; i++) {
        [self.layers[i] removeAllAnimations];
    }
}

- (void)configureUI {
    NSArray *h = @[@0.6,@1.0,@0.7,@0.9];
    for (int i = 0; i < 4; i ++) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, nil, CGRectGetWidth(self.frame) * kJMBeatingAudio * i, CGRectGetHeight(self.frame));
        
        CGPathAddLineToPoint(path, nil, CGRectGetWidth(self.frame) * kJMBeatingAudio * i, 0);
        layer.path = path;
        layer.lineWidth = 1.5;
        layer.strokeColor = SRGBCOLOR_HEX(0xf23f48).CGColor;
        [self.layer addSublayer:layer];
        
        [self.layers addObject:layer];
        layer.strokeEnd = [h[i] floatValue];
        CGPathRelease(path);
    }
}

- (void)animationB{
    NSArray *f = @[@0.9,@0.2,@1.0,@0.1];
    NSArray *f2 = @[@0.6,@0.6,@0.6,@0.5];
    NSArray *f3 = @[@0.3,@0.9,@0.4,@0.8];
    
    for (int i=0; i< 4; i++) {
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
        
        animation.values = [NSArray arrayWithObjects:
                            f[i],
                            f2[i],
                            f3[i],
                            nil];
        animation.duration	= 0.5;
        animation.repeatCount = HUGE;
        animation.autoreverses = YES;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        [self.layers[i] addAnimation:animation forKey:kJMBeatingAudioKey];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
