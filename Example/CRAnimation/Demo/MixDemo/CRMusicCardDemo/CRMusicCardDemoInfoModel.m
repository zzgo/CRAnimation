//
//  CRMusicCardDemoInfoModel.m
//  CRAnimation
//
//  Created by Bear on 16/10/12.
//  Copyright © 2016年 BearRan. All rights reserved.
//

#import "CRMusicCardDemoInfoModel.h"

@implementation CRMusicCardDemoInfoModel

- (void)fillDemoInfo
{
    self.demoVCName     = @"CRMusicCardDemoVC";
    self.demoGifName    = @"CRMusicCardDemoVC.gif";
    self.demoType       = kCRDemoTypeCombination;
    self.CRID           = @"C0001";
    self.demoName       = @"音乐切换动效";
    self.demoSummary    = @"CRCardAnimationView和CRImageGradientView的组合动效";
    self.codeLanguage   = kCRLanguageTypeObjectiveC;
    
    self.originGitHubAddress            = @"";
    self.homePage                       = @"";
    self.authorInfo                     = self.authorInfo;
    self.UIDesignerInfo                 = self.UIDesignerInfo;
    
}

- (CRStaffInfoModel *)authorInfo
{
    CRStaffInfoModel *authorInfo = [CRStaffInfoModel new];
    authorInfo.realName = @"";
    authorInfo.nickName = @"Bear";
    authorInfo.mail     = @"648070256@qq.com";
    authorInfo.qq       = @"";
    authorInfo.homePage = @"";
    authorInfo.professionType = kProfessionTypeiOSDeveloper;
    
    return authorInfo;
}

@end
