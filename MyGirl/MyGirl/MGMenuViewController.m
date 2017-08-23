//
//  MGMenuViewController.m
//  MyGirl
//
//  Created by liguang on 2017/8/23.
//  Copyright © 2017年 Firstlight. All rights reserved.
//

#import "MGMenuViewController.h"
#import "MGImageShowViewController.h"
#import "MGGameViewController.h"
#import "MGBridViewController.h"

@implementation MGMenuViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *backView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background"]];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
//    NSArray *imageList = @[[UIImage imageNamed:@"menuChat.png"], [UIImage imageNamed:@"menuUsers.png"], [UIImage imageNamed:@"menuMap.png"], [UIImage imageNamed:@"menuClose.png"]];
    NSArray *titles = @[@"我们的故事",@"爱的弹弹",@"8888",@"56"];
    sideBar = [[CDSideBarController alloc] initWithTitles:titles];
    sideBar.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [sideBar insertMenuButtonOnView:self.view atPosition:CGPointMake(self.view.frame.size.width - 70, 50)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark - CDSideBarController delegate

- (void)menuButtonClicked:(int)index
{
    // Execute what ever you want
    if (index == 0) {
        MGImageShowViewController *gameVC = [[MGImageShowViewController alloc]init];
        [self.navigationController pushViewController:gameVC animated:YES];
    }else if (index == 1){
        MGGameViewController *gameVC = [[MGGameViewController alloc]init];
        [self.navigationController pushViewController:gameVC animated:YES];
    }else if (index == 2){
        MGBridViewController *gameVC = [[MGBridViewController alloc]init];
        [self.navigationController pushViewController:gameVC animated:YES];
    }else if (index == 3){
        
    }
}
@end
