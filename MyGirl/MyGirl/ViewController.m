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

@interface ViewController () <UITextFieldDelegate,HYPasswordViewDelegate>


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //输入
    HYPasswordFieldModel *model = [HYPasswordFieldModel hyPasswordFieldModelWithSize:CGSizeMake(50, 50) margin:5 count:PassWordCount];
    HYPasswordView *passwordView = [HYPasswordView hyPasswordViewWithWidthFieldModel:model];
    [self.view addSubview:passwordView];
    
    [passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(50*PassWordCount + 5*(PassWordCount -1)));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(100);
        make.height.equalTo(@50);
    }];
    passwordView.delegate = self;
    
}
#pragma mark password
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"range:%@",NSStringFromRange(range));
    NSLog(@"string:%@",string);
    return YES;
}

-(void)hyPasswordDidEndInput:(HYPasswordView *)passwordView andPasswordStr:(NSString *)passwordStr
{
    NSLog(@"%@",passwordStr);
}



@end
