//
//  ViewController.m
//  WJMinutesCircleDemo
//
//  Created by Macintosh on 16/3/18.
//  Copyright © 2016年 mactoinsh. All rights reserved.
//

#import "ViewController.h"
#import "FFProgressView.h"

@interface ViewController ()
@property(nonatomic) UIButton *getButton;//获取验证码+重新获取

@property(weak, nonatomic) FFProgressView *progressView;

@property (nonatomic,assign)  NSInteger second; // 倒计时时间
@property (nonatomic,strong) UILabel * numLabel; // 倒计时 label

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 默认倒计时为60
    self.second = 60;
    
    //验证码
    UILabel *getLable = [[UILabel alloc] initWithFrame:CGRectMake(15*kScaleW, 85*kScaleH, 200*kScaleW, 40*kScaleH)];
    getLable.text = @"验证码";
    getLable.textColor = FFColor(50, 51, 52);
    getLable.font = [UIFont systemFontOfSize:16*kScaleW];
    [self.view addSubview:getLable];
    
    UITextField *vertifyTF = [[UITextField alloc] initWithFrame:CGRectMake(95*kScaleW, 86*kScaleH, 150*kScaleW, 40*kScaleH)];
    vertifyTF.placeholder = @"请输入验证码";
    vertifyTF.font = [UIFont systemFontOfSize:16*kScaleW];
    [self.view addSubview:vertifyTF];
    
    //获取验证码button
    self.getButton = [[UIButton alloc] initWithFrame:CGRectMake(275*kScaleW, 92*kScaleH, 80*kScaleW, 26*kScaleH)];
    [self.getButton setImage:[UIImage imageNamed:@"获取验证码"] forState:UIControlStateNormal];
    [self.view addSubview:self.getButton];
    [self.getButton addTarget:self
                       action:@selector(getCode:)
             forControlEvents:UIControlEventTouchUpInside];
    
    //上下两条线
    UIView *oneLine = [[UIView alloc] initWithFrame:CGRectMake(0, 80*kScaleH, kScreenWidth, 1*kScaleH)];
    oneLine.backgroundColor = FFColor(219, 220, 221);
    [self.view addSubview:oneLine];
    
    UIView *twoLine = [[UIView alloc] initWithFrame:CGRectMake(0, 129*kScaleH, kScreenWidth, 1*kScaleH)];
    twoLine.backgroundColor = FFColor(219, 220, 221);
    [self.view addSubview:twoLine];

    
}

- (void)getCode:(UIButton *)sender {
    
    
    FFProgressView *progressView = [[FFProgressView alloc]
                                    initWithFrame:CGRectMake(
                                            320*kScaleW,
                                            87*kScaleH,
                                            35 * kScaleH,
                                            35 * kScaleH)];
    
    progressView.backgroundColor = [UIColor clearColor];
    [sender.superview addSubview:progressView];
    progressView.radius = (35 * kScaleH - 5*kScaleW) * 0.5;
    [progressView setNeedsDisplay];
    
    self.numLabel =[ [UILabel alloc] initWithFrame:progressView.frame];
    self.numLabel.text = @"60";
    self.numLabel.font = [UIFont systemFontOfSize:14*kScaleW];
    self.numLabel.textColor = [UIColor orangeColor];
    self.numLabel.textAlignment = NSTextAlignmentCenter;
    [sender.superview addSubview:self.numLabel];
    
    // 隐藏 获取验证码 按钮
    sender.hidden = YES;
    
    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(timeChange:)
                                   userInfo:nil
                                    repeats:YES];
    
    self.progressView = progressView;
}

// 一秒一次 变换进度
- (void)timeChange:(NSTimer *)sender {
    
    self.numLabel.text = [NSString stringWithFormat:@"%zd",    --self.second];
    
    // 自身+60分之1
    self.progressView.progress = self.progressView.progress + 1 / 60.0;
    
    if (self.progressView.progress >= 1) {
        // 销毁计时器
        [sender invalidate];
        // 移除进度
        [self.progressView removeFromSuperview];
        // 更换按钮蚊子
        [self.getButton setImage:[UIImage imageNamed:@"重新获取"]
                        forState:UIControlStateNormal];
        // 显示 获取验证码/重新获取 按钮
        self.getButton.hidden = NO;
        
        // 移除倒计时的label
        [self.numLabel removeFromSuperview];
        
        // 重置倒计时时间
        self.second = 60;
        return;
    }
    [self.progressView setNeedsDisplay];
}

//点击屏幕时结束编辑,取消键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
