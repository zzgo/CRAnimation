//
//  CRGatlingModel.m
//  CRAnimation
//
//  Created by I_MT on 2016/11/8.
//  Copyright © 2016年 BearRan. All rights reserved.
//

#import "CRGatlingModel.h"

@implementation CRGatlingModel
- (void)fillDemoInfo
{
    self.demoVCName     = @"CRGatlingVC";
    self.demoGifName    = @"GatlingProgress.gif";
    self.demoType       = kCRDemoTypeStorage;
    self.CRID           = @"S0007";
    self.demoName       = @"CRGatling";
    self.demoSummary    = @"加特林进度条";
    self.codeLanguage   = kCRLanguageTypeObjectiveC;
    
    self.originGitHubAddress            = @"https://github.com/JMT451/CRGatling";
    self.homePage                       = @"";
    self.authorInfo                     = self.authorInfo;
    self.UIDesignerInfo                 = self.UIDesignerInfo;
    
}

- (CRStaffInfoModel *)authorInfo
{
    CRStaffInfoModel *authorInfo = [CRStaffInfoModel new];
    authorInfo.realName = @"";
    authorInfo.nickName = @"MT";
    authorInfo.mail     = @"1399140589@gmail.com";
    authorInfo.homePage = @"";
    authorInfo.qq       = @"1399140589";
    authorInfo.professionType = kProfessionTypeiOSDeveloper;
    
    return authorInfo;
}

@end
