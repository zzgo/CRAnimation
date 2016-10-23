//
//  CRDemoInfoModel.m
//  CRAnimation
//
//  Created by Bear on 16/10/7.
//  Copyright © 2016年 BearRan. All rights reserved.
//

#import "CRDemoInfoModel.h"

@implementation CRDemoInfoModel

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self fillDemoInfo];
    }
    
    return self;
}

- (void)fillDemoInfo
{
    self.demoVCName     = @"";
    self.demoGifName    = @"";
    self.demoType       = kCRDemoTypeStorage;
    self.CRID           = @"S0001";
    self.demoName       = @"";
    self.demoSummary    = @"";
    self.codeLanguage   = kCRLanguageTypeSwift;
    
    self.originGitHubAddress            = @"";
    self.homePage                       = @"";
    self.authorInfo                     = self.authorInfo;
    self.UIDesignerInfo                 = self.UIDesignerInfo;
    
}

- (CRStaffInfoModel *)authorInfo
{
    CRStaffInfoModel *authorInfo = [CRStaffInfoModel new];
    authorInfo.realName = @"";
    authorInfo.nickName = @"";
    authorInfo.mail     = @"";
    authorInfo.qq       = @"";
    authorInfo.homePage = @"";
    authorInfo.professionType = kProfessionTypeiOSDeveloper;
    
    return authorInfo;
}

@end
