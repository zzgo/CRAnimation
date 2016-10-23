//
//  CRCardAnimationViewDemoInfoModel.m
//  CRAnimation
//
//  Created by Bear on 16/10/12.
//  Copyright © 2016年 BearRan. All rights reserved.
//

#import "CRCardAnimationViewDemoInfoModel.h"

@implementation CRCardAnimationViewDemoInfoModel

- (void)fillDemoInfo
{
    self.demoVCName     = @"CRCardAnimationViewDemoVC";
    self.demoGifName    = @"CRCardAnimationViewDemoVC.gif";
    self.demoType       = kCRDemoTypeStorage;
    self.CRID           = @"S0001";
    self.demoName       = @"CRCardAnimationView";
    self.demoSummary    = @"卡片切换动效";
    self.codeLanguage   = kCRLanguageTypeObjectiveC;
    
    self.originGitHubAddress            = @"https://github.com/BearRan/CRAnimation";
    self.homePage                       = @"https://github.com/BearRan/CRAnimation";
    self.authorInfo                     = self.authorInfo;
    self.UIDesignerInfo                 = self.UIDesignerInfo;
    
}

- (CRStaffInfoModel *)authorInfo
{
    CRStaffInfoModel *authorInfo = [CRStaffInfoModel new];
    authorInfo.realName = @"";
    authorInfo.nickName = @"Bear";
    authorInfo.mail     = @"648070256@qq.com";
    authorInfo.qq       = @"648070256";
    authorInfo.homePage = @"";
    authorInfo.professionType = kProfessionTypeiOSDeveloper;
    
    return authorInfo;
}

@end
