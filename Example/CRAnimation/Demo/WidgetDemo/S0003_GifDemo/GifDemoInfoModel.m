//
//  GifDemoInfoModel.m
//  CRAnimation
//
//  Created by Bear on 16/10/12.
//  Copyright © 2016年 BearRan. All rights reserved.
//

#import "GifDemoInfoModel.h"

@implementation GifDemoInfoModel

- (void)fillDemoInfo
{
    self.demoVCName     = @"GifDemoVC";
    self.demoGifName    = @"GifPlay.gif";
    self.demoType       = kCRDemoTypeStorage;
    self.CRID           = @"S0003";
    self.demoName       = @"Gif demo";
    self.demoSummary    = @"Gif播放控件";
    self.codeLanguage   = kCRLanguageTypeObjectiveC;
    
    self.originGitHubAddress            = @"https://github.com/Flipboard/FLAnimatedImage";
    self.homePage                       = @"https://github.com/Flipboard/FLAnimatedImage";
    self.authorInfo                     = self.authorInfo;
    self.UIDesignerInfo                 = self.UIDesignerInfo;
    
}

- (CRStaffInfoModel *)authorInfo
{
    CRStaffInfoModel *authorInfo = [CRStaffInfoModel new];
    authorInfo.realName = @"";
    authorInfo.nickName = @"Flipboard";
    authorInfo.mail     = @"";
    authorInfo.qq       = @"";
    authorInfo.homePage = @"https://github.com/Flipboard/FLAnimatedImage";
    authorInfo.professionType = kProfessionTypeiOSDeveloper;
    
    return authorInfo;
}

@end
