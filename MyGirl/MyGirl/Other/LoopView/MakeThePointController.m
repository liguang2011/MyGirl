//
//  MakeThePointController.m
//  Loop
//
//  Created by vcube on 2017/2/14.
//  Copyright © 2017年 YangHe. All rights reserved.
//

#import "MakeThePointController.h"

@implementation MakeThePointController

+ (CGPoint)getThePointByFirstPoint:(CGPoint)firstPoint secPoint:(CGPoint)secPoint
{
    
    if (secPoint.y > firstPoint.x) {
        
        CGFloat endX = firstPoint.x - (secPoint.x - firstPoint.x) * 1.0;
        
        CGFloat endY = firstPoint.y - (secPoint.y - firstPoint.y) * 2;
        
        CGPoint endPoint = CGPointMake(endX, endY);
        
        return endPoint;
        
    }else{
        
        CGPoint endPoint = CGPointMake(0, 0);
        
        return endPoint;
        
    }
    
}


@end
