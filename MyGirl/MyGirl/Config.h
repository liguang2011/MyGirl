//
//  Config_h
//  BHHouse
//
//  Created by liguang on 2017/6/14.
//  Copyright © 2017年 liguang. All rights reserved.
//

#ifndef Config_h
#define Config_h

//获取系统对象
#define kApplication        [UIApplication sharedApplication]
#define kAppWindow          [UIApplication sharedApplication].delegate.window
#define kAppDelegate        [AppDelegate shareAppDelegate]
#define kRootViewController [UIApplication sharedApplication].delegate.window.rootViewController
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]

//强弱引用 (用法 block外@weakify block内@stongify block里直接用self)
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

//日志
#ifdef DEBUG
#define BHLog(format, ...) NSLog((@"%s [Line %d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define BHLog(...)
#endif

//------------------------------------尺寸相关----------------------------------//
#define kBounds         [UIScreen mainScreen].bounds //屏幕bounds
#define kWidth          [UIScreen mainScreen].bounds.size.width //屏宽
#define kHeight         [UIScreen mainScreen].bounds.size.height //屏高

//最大最小值
#define MaxX(frame)     CGRectGetMaxX(frame)
#define MaxY(frame)     CGRectGetMaxY(frame)
#define MinX(frame)     CGRectGetMinX(frame)
#define MinY(frame)     CGRectGetMinY(frame)
//宽度高度
#define Width(frame)    CGRectGetWidth(frame)
#define Height(frame)   CGRectGetHeight(frame)

//------------------------------------字体颜色相关----------------------------------//
//快速生成颜色
#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

//16进制颜色 BHColor(0xaaaaaa)
#define BHColor(_color) [UIColor colorWithRed:((_color>>16)&0xff)/255.0f green:((_color>>8)&0xff)/255.0f blue:(_color&0xff)/255.0f alpha:1]

#define kHexColor(_color) [UIColor colorWithRed:((_color>>16)&0xff)/255.0f green:((_color>>8)&0xff)/255.0f blue:(_color&0xff)/255.0f alpha:1]

#define kTextColor kHexColor(0x4a4a4a)

//16进制颜色 BHColorAlpha(0xaaaaaa,0.5)
#define kHexColorAlpha(rgbValue, alphaValue)  \[UIColor \
 colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
 green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
 blue:((float)(rgbValue & 0x0000FF))/255.0 \
 alpha:alphaValue]


//字体
#define kFontFZYANS_CUJW(_size)     [UIFont fontWithName:@"FZYANS_CUJW--GB1-0" size:_size]


#define kFont(n)                    [UIFont systemFontOfSize:(GTFixWidthFloat(n))]
#define kFontScale(n)               [UIFont systemFontOfSize:(GTFixWidthFloat(n))]
#define kFontNormal(n)              [UIFont systemFontOfSize:(n)]
#define kFontBold(n)                [UIFont boldSystemFontOfSize:(n)]

//------------------------------------图片相关----------------------------------//
//加载本地图片
#define kLoadImage(imageName) [UIImage imageNamed:imageName]
//加载不缓存图片
#define kLoadImage_NotCache(imageName, imageType) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:imageType]]

//-------------------------------------单例----------------------------------//
#define shareSingleH(name) +(instancetype)share##name;

#if __has_feature(objc_arc)

#define shareSingleM(name) static id _instance;\
+(instancetype)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
\
+(instancetype)share##name\
{\
return [[self alloc]init];\
}\
-(id)copyWithZone:(NSZone *)zone\
{\
return _instance;\
}\
\
-(id)mutableCopyWithZone:(NSZone *)zone\
{\
return _instance;\
}

#else
#define shareSingleM static id _instance;\
+(instancetype)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
\
+(instancetype)shareTools\
{\
return [[self alloc]init];\
}\
-(id)copyWithZone:(NSZone *)zone\
{\
return _instance;\
}\
\
-(id)mutableCopyWithZone:(NSZone *)zone\
{\
return _instance;\
}\
-(oneway void)release\
{\
}\
\
-(instancetype)retain\
{\
return _instance;\
}\
\
-(NSUInteger)retainCount\
{\
return MAXFLOAT;\
}
#endif

#endif /* Config_h */
