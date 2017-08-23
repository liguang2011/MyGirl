//
//  ViewController.m
//  MyGirl
//
//  Created by 李光 on 2017/8/22.
//  Copyright © 2017年 Firstlight. All rights reserved.
//

#define PassWordCount 4

#import "ViewController.h"
#import "HYPasswordView.h"
#import "YJWaveAnimationInTool.h"
#import "MGGameViewController.h"
#import "MGBridViewController.h"
#import "MGMenuViewController.h"


@interface ViewController () <UITextFieldDelegate,HYPasswordViewDelegate>
{
    HYPasswordView *_passwordView;
    UILabel *_tipLabel;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //输入
    [self addTextField];
    [self addTip];
}
#pragma mark addView
- (void)addTextField
{
    HYPasswordFieldModel *model = [HYPasswordFieldModel hyPasswordFieldModelWithSize:CGSizeMake(50, 50) margin:5 count:PassWordCount];
    HYPasswordView *passwordView = [HYPasswordView hyPasswordViewWithWidthFieldModel:model];
    [self.view addSubview:passwordView];
    _passwordView = passwordView;
    [passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(50*PassWordCount + 5*(PassWordCount -1)));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(100);
        make.height.equalTo(@50);
    }];
    passwordView.delegate = self;
}

- (void)addTip
{
    UILabel *tipLabel = [[UILabel alloc]init];
    [self.view addSubview:tipLabel];
    _tipLabel = tipLabel;
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwordView.mas_bottom).offset(30);
        make.left.right.equalTo(self.view);
    }];
    tipLabel.textColor = kTextColor;
    tipLabel.font = kFontNormal(15);
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.text = @"*笨笨,密码是你的生日啦*";
    tipLabel.alpha = 0;
}

#pragma mark password
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

-(void)hyPasswordDidEndInput:(HYPasswordView *)passwordView andPasswordStr:(NSString *)passwordStr
{
    NSLog(@"%@",passwordStr);
    if (![passwordStr isEqualToString:@"1028"]) {
        [UIView animateWithDuration:2 animations:^{
            _tipLabel.alpha = 1;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:2 animations:^{
                _tipLabel.alpha = 0;
            }];
        }];
    }else {
        MGMenuViewController *gameVC = [[MGMenuViewController alloc]init];
        [gameVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:gameVC] animated:YES completion:nil];
    }
}



@end
