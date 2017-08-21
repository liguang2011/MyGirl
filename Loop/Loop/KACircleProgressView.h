//
//  KACircleProgressView.h
//  Loop
//
//  Created by V－CUBE TJ on 16/7/29.
//  Copyright © 2016年 YangHe. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface KACircleProgressView : UIView {
    
    CAShapeLayer *_trackLayer;
    
    UIBezierPath *_trackPath;
    
    CAShapeLayer *_progressLayer;
    
    UIBezierPath *_progressPath;
    
}


@property (nonatomic, assign) CGPoint a;

@property (nonatomic, strong) UIColor *trackColor;

@property (nonatomic, strong) UIColor *progressColor;

@property (nonatomic) float progress;//0~1之间的数

@property (nonatomic) float progressWidth;

- (void)setPointStar:(CGPoint)star end:(CGPoint)end;

- (void)setProgress:(float)progress animated:(BOOL)animated;
@end
