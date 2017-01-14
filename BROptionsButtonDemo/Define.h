//
//  Define.h
//  BROptionsButtonDemo
//
//  Created by chi on 14/01/2017.
//  Copyright © 2017 Basheer Malaa. All rights reserved.
//


#define DEBUG

// 時間計測に使用
#define BM_START(name) NSDate *name##_start = [NSDate new]
#define BM_END(name)   NSDate *name##_end = [NSDate new];\
NSLog(@"%s interval: %f", #name, [name##_end timeIntervalSinceDate:name##_start]);\
[name##_start release];[name##_end release]


// デバッグ用マクロ
#ifdef DEBUG
#  define LOG(...) NSLog(__VA_ARGS__)
#  define LOG_CURRENT_METHOD NSLog(@"%@/%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd))
#else
#  define LOG(...) ;
#  define LOG_CURRENT_METHOD ;
#endif


// ファイル名（行番号）で出力
#ifdef DEBUG
#define NKDPRINT(xx, ...)  NSLog(@"%s(%d): " xx, __FILE__, __LINE__, ##__VA_ARGS__)
#else
#define NKDPRINT(xx, ...)  ((void)0)
#endif


#ifdef DEBUG
# define TRACE(fmt, ...) NSLog((@"%s(%d) " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define TRACE(...)
#endif

//画面サイズ取得マクロ
#define SCREEN_WIDTH ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define SCREEN_HEIGHT ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)
