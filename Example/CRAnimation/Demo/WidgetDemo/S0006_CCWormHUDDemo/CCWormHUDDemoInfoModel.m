//
//  CCWormHUDDemoInfoModel.m
//  CRAnimation
//
//  Created by Cocos on 2016/11/7.
//  Copyright © 2016年 Cocos. All rights reserved.
//

#import "CCWormHUDDemoInfoModel.h"

@implementation CCWormHUDDemoInfoModel

- (void)fillDemoInfo
{
    self.demoVCName     = @"CCWormHUDDemoVC";
    self.demoGifName    = @"a-diligent-worm-in-iOS.gif";
    self.demoType       = kCRDemoTypeStorage;
    self.CRID           = @"S0006";
    self.demoName       = @"CCWormHUD";
    self.demoSummary    = @"虫儿跑";
    self.codeLanguage   = kCRLanguageTypeObjectiveC;
    
    self.originGitHubAddress            = @"https://github.com/BearRan/CRAnimation";
    self.homePage                       = @"https://github.com/BearRan/CRAnimation";
    self.authorInfo                     = self.authorInfo;
    self.UIDesignerInfo                 = self.UIDesignerInfo;
    
}

- (CRStaffInfoModel *)authorInfo
{
    CRStaffInfoModel *authorInfo = [CRStaffInfoModel new];
    authorInfo.realName = @"Cocos";
    authorInfo.nickName = @"C";
    authorInfo.mail     = @"543314602@qq.com";
    authorInfo.qq       = @"543314602";
    authorInfo.homePage = @"blog.cocosdever.com";
    authorInfo.professionType = kProfessionTypeiOSDeveloper;
    
    return authorInfo;
}

@end
