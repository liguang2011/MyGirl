//
//  KACircleProgressView.m
//  Loop
//
//  Created by V－CUBE TJ on 16/7/29.
//  Copyright © 2016年 YangHe. All rights reserved.
//

#import "KACircleProgressView.h"

@implementation KACircleProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
            
        // Initialization code
        _trackLayer = [CAShapeLayer new];
        
        [self.layer addSublayer:_trackLayer];
        
        _trackLayer.fillColor = nil;
        
        _trackLayer.frame = self.bounds;
        
        _progressLayer = [CAShapeLayer new];
        
        [self.layer addSublayer:_progressLayer];
        
        _progressLayer.fillColor = nil;
        
        _progressLayer.lineCap = kCALineCapRound;
        
        _progressLayer.frame = self.bounds;
        
        //默认5
        self.progressWidth = 5;
    }
    return self;
}

- (void)setTrack
{
    _trackPath = [UIBezierPath bezierPath];
    // 添加路径[1条点(100,100)到点(200,100)的线段]到path
    [_trackPath moveToPoint:CGPointMake(100 , 350)];
    [_trackPath addLineToPoint:self.a];
    // 将path绘制出来

    UIGraphicsBeginImageContext(self.bounds.size);
    [_trackPath stroke];
    UIGraphicsEndImageContext();
    
//    _trackPath = [UIBezierPath bezierPathWithArcCenter:self.center radius:(self.bounds.size.width - _progressWidth)/ 2 startAngle:0 endAngle:M_PI * 2 clockwise:NO];;
    
    _trackLayer.path = _trackPath.CGPath;
    
}

- (void)setProgress
{

    _progressPath = [UIBezierPath bezierPath];
    // 添加路径[1条点(100,100)到点(200,100)的线段]到path
    [_progressPath moveToPoint:CGPointMake([UIScreen mainScreen].bounds.size.width - 100 , 350)];
    [_progressPath addLineToPoint:self.a];
    // 将path绘制出来
    UIGraphicsBeginImageContext(self.bounds.size);
    [_progressPath stroke];
    UIGraphicsEndImageContext();
    
    [_progressPath closePath];
//    _progressPath = [UIBezierPath bezierPathWithArcCenter:self.center radius:(self.bounds.size.width - _progressWidth)/ 2 startAngle:-M_PI_2 endAngle:(M_PI * 2) * _progress - M_PI_2 clockwise:NO];
    
    _progressLayer.path = _progressPath.CGPath;
    
    
}



- (void)setProgressWidth:(float)progressWidth
{
    _progressWidth = progressWidth;
    
    _trackLayer.lineWidth = _progressWidth;
    
    _progressLayer.lineWidth = _progressWidth;
    
    [self setTrack];
    
    [self setProgress];
}

- (void)setTrackColor:(UIColor *)trackColor
{
    _trackLayer.strokeColor = trackColor.CGColor;
}

- (void)setProgressColor:(UIColor *)progressColor
{
    _progressLayer.strokeColor = progressColor.CGColor;
}

- (void)setProgress:(float)progress
{
    _progress = progress;
    
    [self setProgress];
}


#pragma mark - 白色status bar
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (void)setProgress:(float)progress animated:(BOOL)animated
{
    

    [_progressPath removeAllPoints];
    
    [_trackPath removeAllPoints];
    
    [self setTrack];
    
    [self setProgress];
    
    
    
}



//- (void)setPointStar:(CGPoint)star end:(CGPoint)end
//{
//    
//    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    
//    pathAnima.duration = 1.0f;
//    
//    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    
//    pathAnima.fromValue = (__bridge id _Nullable)(_progressPath.CGPath);
//    
//    UIBezierPath* aaa = [UIBezierPath bezierPath];
//    
//    [aaa moveToPoint:CGPointMake([UIScreen mainScreen].bounds.size.width , 50)];
//    
//    [aaa addLineToPoint:star];
//    
//    pathAnima.toValue = (__bridge id _Nullable)(aaa.CGPath);
//    
//    [_progressLayer addAnimation:pathAnima forKey:@"strokeEndAnimation"];
//
//}




/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 } 
 */  

@end
