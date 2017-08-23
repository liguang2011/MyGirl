//
//  MGBridViewController.m
//  MyGirl
//
//  Created by 李光 on 2017/8/23.
//  Copyright © 2017年 Firstlight. All rights reserved.
//

#import "MGBridViewController.h"

@interface MGBridViewController ()
//实现动画
@property (nonatomic, strong)UIDynamicAnimator *dynamicAnimator;
//动画元素行为
@property (nonatomic, strong)UIDynamicItemBehavior *dynamicItemBehavior;
//碰撞行为
@property (nonatomic, strong)UICollisionBehavior *collisionBehavior;
//重力行为
@property (nonatomic, strong)UIGravityBehavior *gravityBehavior;
@end

@implementation MGBridViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //实力动画
    _dynamicAnimator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    
    _dynamicItemBehavior = [[UIDynamicItemBehavior alloc]init];
    
    //弹力  数值越大，弹力越大
    _dynamicItemBehavior.elasticity = 1;
    
    //碰撞
    _collisionBehavior = [[UICollisionBehavior alloc]init];
    
    //刚体碰撞
    _collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    
    //重力
    _gravityBehavior = [[UIGravityBehavior alloc]init];
    
    //把行为放进动画里
    [_dynamicAnimator addBehavior:_dynamicItemBehavior];
    
    [_dynamicAnimator addBehavior:_collisionBehavior];
    
    [_dynamicAnimator addBehavior:_gravityBehavior];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    NSArray * imageArray = @[@"bird1",@"bluebird1",@"ice1",@"pig_44",@"yellowbird1",@"shelf1",@"1",@"pig1",];
//    NSMutableArray * imageArray = [@[@"boy.jpg",@"myGirl"] mutableCopy];
    
    
    int x = arc4random() % (int)self.view.bounds.size.width;
    
    int siz = arc4random() % 50 + 30;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, 10, siz, siz)];
    
//    imageView.image = [UIImage imageNamed:imageArray[arc4random() % imageArray.count]];
    
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"family%zi.jpg",arc4random() % 98]];
    
    imageView.layer.cornerRadius = imageView.height/2;
    imageView.layer.masksToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    
    
    //添加行为
    [_dynamicItemBehavior addItem:imageView];
    
    [_gravityBehavior addItem:imageView];
    
    [_collisionBehavior addItem:imageView];
}


@end
