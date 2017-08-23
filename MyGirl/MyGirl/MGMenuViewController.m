//
//  MGMenuViewController.m
//  MyGirl
//
//  Created by liguang on 2017/8/23.
//  Copyright © 2017年 Firstlight. All rights reserved.
//

#define SNOW_IMAGENAME         @"sakulaFlower"

// MainScreen Height&Width
#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width

#define IMAGE_X                arc4random()%(int)Main_Screen_Width
#define IMAGE_ALPHA            ((float)(arc4random()%50))/10
#define IMAGE_WIDTH            arc4random()%20 + 70
#define PLUS_HEIGHT            Main_Screen_Height/25

#define MWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
//#define kScreenSize    [UIScreen mainScreen].bounds.size

#import "MGMenuViewController.h"
#import "MGImageShowViewController.h"
#import "MGGameViewController.h"
#import "MGBridViewController.h"
#import "ZYAnimationLayer.h"

@interface MGMenuViewController ()

@property (nonatomic, strong) NSMutableArray *imagesArray;
@property (nonatomic, strong) NSTimer *time;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *textArray;
@property (nonatomic, assign) BOOL isStop;

@end

@implementation MGMenuViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *backView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
    backView.backgroundColor = kHexColor(0xffffff);
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
//    NSArray *imageList = @[[UIImage imageNamed:@"menuChat.png"], [UIImage imageNamed:@"menuUsers.png"], [UIImage imageNamed:@"menuMap.png"], [UIImage imageNamed:@"menuClose.png"]];
    NSArray *titles = @[@"我们的照片",@"要你滚来滚去",@"一起滚来滚去"];
    sideBar = [[CDSideBarController alloc] initWithTitles:titles];
    sideBar.delegate = self;
    
    [self loadSnow];
    
    [self loadText];

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


#pragma mark - 雪花
- (void)loadSnow
{
    _imagesArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 20; ++ i) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:SNOW_IMAGENAME]];
        float x = IMAGE_WIDTH;
        imageView.frame = CGRectMake(IMAGE_X, -70, x, x);
        imageView.alpha = IMAGE_ALPHA;
        [self.view addSubview:imageView];
        [_imagesArray addObject:imageView];
    }
    [NSTimer scheduledTimerWithTimeInterval:.3 target:self selector:@selector(makeSnow) userInfo:nil repeats:YES];
}
static int i = 0;
- (void)makeSnow
{
    i = i + 1;
    if ([_imagesArray count] > 0) {
        UIImageView *imageView = [_imagesArray objectAtIndex:0];
        imageView.tag = i;
        [_imagesArray removeObjectAtIndex:0];
        [self snowFall:imageView];
    }
    
}
- (void)snowFall:(UIImageView *)aImageView
{
    [UIView beginAnimations:[NSString stringWithFormat:@"%d",(int)aImageView.tag] context:nil];
    [UIView setAnimationDuration:6];
    [UIView setAnimationDelegate:self];
    aImageView.frame = CGRectMake(aImageView.frame.origin.x, Main_Screen_Height, aImageView.frame.size.width, aImageView.frame.size.height);
    [UIView commitAnimations];
}
- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    UIImageView *imageView = (UIImageView *)[self.view viewWithTag:[animationID intValue]];
    float x = IMAGE_WIDTH;
    imageView.frame = CGRectMake(IMAGE_X, -30, x, x);
    [_imagesArray addObject:imageView];
}

-(UIColor *)randomColor
{
    return kHexColor(0x4a4a4a);
//    
//    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
//    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
//    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
//    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

#pragma mark - 文字
- (void)loadText
{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView = scrollView;
    [self.view addSubview:scrollView];
    
    self.textArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"text" ofType:@"plist"]];
    
    self.time = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(markText) userInfo:nil repeats:YES];
}

static int idx = 0;
- (void)markText
{
    if (idx > self.textArray.count - 1) {
        [self.time invalidate];
//        [[MAPlayer sharedMAPlayer]pause];
        self.isStop = YES;
        return;
    }
    NSString *text = self.textArray[idx];
    
    CGFloat height = 40;
    CGFloat width = kScreenSize.width - 50;
    CGRect frame = CGRectMake(25, idx * (height + 10) + 20, width, height);
    
    [ZYAnimationLayer createAnimationLayerWithString:text andRect:frame  andView:self.scrollView andFont:[UIFont boldSystemFontOfSize:15] andStrokeColor:[self randomColor]];
    
    self.scrollView.contentSize = CGSizeMake(width, CGRectGetMaxY(frame));
    CGFloat offsetY = CGRectGetMaxY(frame) - kScreenSize.height + 50;
    [self.scrollView setContentOffset:CGPointMake(0, offsetY > 0 ? offsetY : 0) animated:YES];
    idx++;
    if (text.length == 0) {
        [self markText];
    }
}


@end
