//
//  MGGameViewController.m
//  MyGirl
//
//  Created by 李光 on 2017/8/22.
//  Copyright © 2017年 Firstlight. All rights reserved.
//

#import "MGGameViewController.h"
#import "KACircleProgressView.h"
#import "DDParabolaImageView.h"
#import "MakeThePointController.h"

@interface MGGameViewController ()
{
    CGFloat _value;
    
    CGPoint _firstPoint;
    
    CGPoint _secPoint;
    
    int allTime;
}
@property (nonatomic, strong) KACircleProgressView *progress;

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) DDParabolaImageView *secImg;

@property (nonatomic, strong) NSTimer *countDownTimer;

@property (nonatomic, strong) UILabel *alabel;

@property (nonatomic, strong) NSTimer *timer;
@end

@implementation MGGameViewController


- (UIImageView *)imgView
{
    if (!_imgView) {
        
        self.imgView = [[UIImageView alloc] initWithFrame:(CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 25, 370, 50, 50))];
        
        _imgView.userInteractionEnabled = YES;
        
        _imgView.image = [UIImage imageNamed:@"myGirl"];
        
        _imgView.layer.cornerRadius = 25;
        
        _imgView.layer.masksToBounds = YES;
        
        _imgView.tag = 500;
        
        UIPanGestureRecognizer *panGester = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestuere:)];
        [_imgView addGestureRecognizer:panGester];
    }
    return _imgView;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.progress = [[KACircleProgressView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:self.progress];
    
    _progress.backgroundColor = [UIColor whiteColor];
    
    _progress.trackColor = [UIColor brownColor];
    
    _progress.a = self.imgView.center;
    
    _progress.a = CGPointMake(CGRectGetMidX(self.imgView.frame), CGRectGetMaxY(self.imgView.frame));
    
    _firstPoint = _progress.a;
    
    _progress.progressColor = [UIColor yellowColor];
    
    _progress.progress = 0.01f;
    
    _progress.progressWidth = 10;
    
    [self.view addSubview:self.imgView];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.countDownTimer invalidate];
    
}


#pragma mark - 平移手势实现方法
- (void)handlePanGestuere:(UIPanGestureRecognizer *)penGesture {
    
    // 获取平移增量
    CGPoint point = [penGesture translationInView:penGesture.view];
    
    // 让视图位置发生移动, 以上次视图为基准,transform仿射变换技术
    penGesture.view.transform = CGAffineTransformTranslate(penGesture.view.transform, point.x, point.y);
    
    // 将上次的平移增量置为0
    // CGPointZero == CGPointMake(0, 0);
    [penGesture setTranslation:(CGPointZero) inView:penGesture.view];
    
    _progress.a = CGPointMake(CGRectGetMidX(self.imgView.frame), CGRectGetMaxY(self.imgView.frame));
    
    [_progress setProgress:0.2 animated:YES];
    
    // 监测平移手势, 当手势的状态为结束的时候执行
    if (penGesture.state == UIGestureRecognizerStateEnded){
        
        // 启动定时器
        [self createTime];
        
        self.imgView.alpha = 0.0;
        
        self.secImg = [[DDParabolaImageView alloc] initWithFrame:self.imgView.frame];
        
        _secPoint = CGPointMake(self.imgView.frame.origin.x, self.imgView.frame.origin.y);
        
        [self.view addSubview:self.secImg];
        
        
        // 给图片一个位移动画
        [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:2 initialSpringVelocity:50 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
            
            // 让图片恢复成原来的位置
            self.imgView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 25, 370, 50, 50);
            
        } completion:^(BOOL finished) {
            
            // 关闭定时器
            [self.timer invalidate];
            
        }];
        
        [_secImg parabolaToPoint:[MakeThePointController getThePointByFirstPoint:_firstPoint secPoint:_secPoint] scaleTo:1];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            self.imgView.alpha = 1.0;
            
            [self.secImg removeFromSuperview];
            
        });
    }
}


//创建定时器
- (void)createTime
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.0001 target:self selector:@selector(imageMonitor:) userInfo:nil repeats:YES];
}


- (void)imageMonitor:(NSTimer *)sender
{
    
    CGRect rect = [[self.imgView.layer presentationLayer]frame];  // view指你的动画中移动的view
    
    _progress.a = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    [_progress setProgress:0.1 animated:YES];
    
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)push {

}

@end
