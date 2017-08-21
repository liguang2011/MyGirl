//
//  DDParabolaImageView.m
//  parabolaAnimation
//
//  Created by FYZB on 14-7-3.
//  Copyright (c) 2014年 cloudacc. All rights reserved.
//

#import "DDParabolaImageView.h"
#import <QuartzCore/QuartzCore.h>
@implementation DDParabolaImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        
        self.image = [UIImage imageNamed:@"phonebannerDefault@2x"];
        // Initialization code
    }
    return self;
}

-(void)parabolaToPoint:(CGPoint)point scaleTo:(float)scale{
    [self.layer addAnimation:[self pathAnimationQuadCurveToPoint:point scaleTo:scale] forKey:@"parabola"];
    self.transform =CGAffineTransformMakeScale(scale, scale);
    self.center = point;
}

- (CAAnimation*)pathAnimationQuadCurveToPoint:(CGPoint )pt scaleTo:(float)sc;
{
    float duration = 1.0;
    
    CGPoint orignal =  self.center;
    CGPoint focus = CGPointZero;
    CGPoint symPoint = CGPointZero;
    CGPoint destPoint = pt;
    focus.x = orignal.x + (destPoint.x - orignal.x)/2;
    focus.y = orignal.y - (destPoint.y + orignal.y);
    
    symPoint.x = 2* focus.x - orignal.x;
    symPoint.y = orignal.y;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path,NULL,orignal.x,orignal.y);
    CGPathAddQuadCurveToPoint(path,NULL,focus.x ,focus.y,destPoint.x,destPoint.y);
    CAKeyframeAnimation *
    animation = [CAKeyframeAnimation
                 animationWithKeyPath:@"position"];
    [animation setPath:path];
    [animation setDuration:duration];
    //    [animation setKeyTimes:@[@0,@1,@3]];
    CFRelease(path);
    CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @1.0;
    scaleAnimation.toValue = [NSNumber numberWithFloat:sc];
    scaleAnimation.duration = duration;
    
    
    CAAnimationGroup * animationGp = [CAAnimationGroup animation];
    animationGp.duration = duration;
    animationGp.animations = @[animation,scaleAnimation];
    return animationGp;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
