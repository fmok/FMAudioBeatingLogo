//
//  ViewController.m
//  FMAudioBeatingLogo
//
//  Created by fm on 2017/3/23.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "ViewController.h"
#import "FMAudioBeatingLogo.h"
#import "FMAudioManager.h"

@interface ViewController ()
{
    BOOL selectState;
}

@property (nonatomic, strong) FMAudioBeatingLogo *audioLogo;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    selectState = NO;
    [self.view addSubview:self.audioLogo];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    selectState = !selectState;
    if (selectState) {
        [FMAudioManager shareInfo].isPlay = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:audioSignStyleChange object:nil userInfo:@{@"style":@(JMAudioSignStyleJump)}];
    } else {
        [FMAudioManager shareInfo].isPlay = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:audioSignStyleChange object:nil userInfo:@{@"style":@(JMAudioSignStyleStop)}];
    }
}

- (FMAudioBeatingLogo *)audioLogo
{
    if (!_audioLogo) {
        _audioLogo = [[FMAudioBeatingLogo alloc] initWithFrame:CGRectMake(100, 100, 40, 40)];
        _audioLogo.isNeedHiddenWhenStop = NO;
    }
    return _audioLogo;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
