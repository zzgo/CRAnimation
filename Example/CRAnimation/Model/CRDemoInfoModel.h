//
//  CRDemoInfoModel.h
//  CRAnimation
//
//  Created by Bear on 16/10/7.
//  Copyright © 2016年 BearRan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CRStaffInfoModel.h"

typedef enum {
    kCRDemoTypeStorage,       //  动效仓库
    kCRDemoTypeCombination,   //  组合动效
} CRDemoType;

typedef enum {
    kCRLanguageTypeObjectiveC,  //  Objective-C
    kCRLanguageTypeSwift,       //  Swift
} CRLanguage;

@interface CRDemoInfoModel : NSObject

//  Require
//  demoVC名称（用于push到指定名称的VC）
@property (strong, nonatomic) NSString      *demoVCName;

//  Require
//  demoGif名称
//  Ex:demoGifName = @"GifPlay.gif"
@property (strong, nonatomic) NSString      *demoGifName;

//  Require
//  动效类型
//  kCRDemoTypeStorage:         动效仓库
//  kCRDemoTypeCombination:     组合动效
@property (assign, nonatomic) CRDemoType    demoType;

//  Require
//  ID编号
//  S0001:动效仓库
//  C0001:组合动效
@property (strong, nonatomic) NSString      *CRID;

//  Require
//  动效名称
@property (strong, nonatomic) NSString      *demoName;

//  Require
//  动效简介
@property (strong, nonatomic) NSString      *demoSummary;

//  Require
//  语言
//  OC/Swift
@property (assign, nonatomic) CRLanguage    codeLanguage;

//  Optional
//  作者源gitHub地址
@property (strong, nonatomic) NSString      *originGitHubAddress;

//  Optional
//  主页／该demo其他相关介绍文章地址，如csdn，简书，blog地址
@property (strong, nonatomic) NSString      *homePage;

//  Require
//  作者信息
@property (strong, nonatomic) CRStaffInfoModel      *authorInfo;

//  Optional
//  UI设计师信息
@property (strong, nonatomic) CRStaffInfoModel      *UIDesignerInfo;


- (void)fillDemoInfo;

@end
