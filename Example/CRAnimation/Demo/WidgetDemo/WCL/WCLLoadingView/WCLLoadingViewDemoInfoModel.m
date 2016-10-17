//
//  WCLLoadingViewDemoInfoModel.m
//  CRAnimation
//
// **************************************************
// *                                  _____         *
// *         __  _  __     ___        \   /         *
// *         \ \/ \/ /    / __\       /  /          *
// *          \  _  /    | (__       /  /           *
// *           \/ \/      \___/     /  /__          *
// *                               /_____/          *
// *                                                *
// **************************************************
//  Github  :https://github.com/631106979
//  HomePage:https://imwcl.com
//  CSDN    :http://blog.csdn.net/wang631106979
//
//  Created by 王崇磊 on 16/9/14.
//  Copyright © 2016年 王崇磊. All rights reserved.
//

#import "WCLLoadingViewDemoInfoModel.h"
#import "CRAnimation_Example-swift.h"

@implementation WCLLoadingViewDemoInfoModel

#pragma mark - Override
- (void)fillDemoInfo
{
    self.demoName       = @"WCLLoadingView";
    self.demoSummary    = @"Slack 的 Loading 动画";
    self.codeLanguage   = kCRLanguageTypeSwift;
    self.author         = @"WCL";
    self.authorMail     = @"wangchonhlei93@icloud.com";
    self.UIDesigner     = @"";
    
    self.UIDesignerMail = @"";
    // 去CRAnimation_Example-swift.h这个头文件里面去看你对于的swift的类名，例如我的就是_TtC19CRAnimation_Example14WCLLoadingView
    self.demoVCName     = @"_TtC19CRAnimation_Example20WCLLoadingViewDemoVC";
    self.demoGifName    = @"WCLLoadingView.gif";
    self.demoType       = kCRDemoTypeStorage;
    self.CRID           = @"S0002";
}

@end
