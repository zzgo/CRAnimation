//
//  CRStaffInfoModel.h
//  CRAnimation
//
//  Created by Bear on 16/10/23.
//  Copyright © 2016年 BearRan. All rights reserved.
//

typedef enum {
    kProfessionTypeiOSDeveloper,    //开发者
    kProfessionTypeDesigner,        //UI设计师
}ProfessionType;

#import <Foundation/Foundation.h>

@interface CRStaffInfoModel : NSObject

//  Optional
//  真实姓名
@property (strong, nonatomic) NSString  *realName;

//  Require
//  昵称
@property (strong, nonatomic) NSString  *nickName;

//  Require
//  邮箱
@property (strong, nonatomic) NSString  *mail;

//  Optional
//  qq
@property (strong, nonatomic) NSString  *qq;

//  Optional
//  个人主页
@property (strong, nonatomic) NSString  *homePage;

//  Require
//  职业
//  kProfessionTypeiOSDeveloper    开发者
//  kProfessionTypeDesigner        UI设计师
@property (assign, nonatomic) ProfessionType  *professionType;

@end
