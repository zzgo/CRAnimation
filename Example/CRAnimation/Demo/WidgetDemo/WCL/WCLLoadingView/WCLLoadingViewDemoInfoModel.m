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

@implementation WCLLoadingViewDemoInfoModel

#pragma mark - Override
- (void)fillDemoInfo
{
    self.demoName       = @"WCLLoadingView";
    self.demoSummary    = @"Slack 的 Loading 动画";
    self.author         = @"WCL";
    self.authorMail     = @"wangchonhlei93@icloud.com";
    self.UIDesigner     = @"";
    
    self.UIDesignerMail = @"";
    self.demoVCName     = @"WCLLoadingViewDemoVC";
    self.demoGifName    = @"WCLLoadingView.gif";
    self.demoType       = kCRDemoTypeStorage;
    self.CRID           = @"S0002";
}

@end
