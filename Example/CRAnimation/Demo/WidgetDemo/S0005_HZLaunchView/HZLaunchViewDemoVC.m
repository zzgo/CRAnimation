//
//  HZLaunchViewDemoVC.m
//  CRAnimation
//
//  Created by zz go on 2016/10/27.
//  Copyright © 2016年 BearRan. All rights reserved.
//

#import <CRAnimation/HZLaunchView.h>
#import "HZLaunchViewDemoVC.h"

@interface HZLaunchViewDemoVC ()

@end

@implementation HZLaunchViewDemoVC

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self createUI];
    [self addTopBar];
}

-(void)createUI{
    
    self.view.backgroundColor = [UIColor grayColor];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UILabel *twitterLabel = [UILabel new];
    twitterLabel.text = @"Hello,twitter. :)";
    twitterLabel.font = [UIFont systemFontOfSize:19];
    [twitterLabel sizeToFit];
    [self.view addSubview:twitterLabel];
    [twitterLabel BearSetCenterToParentViewWithAxis:kAXIS_X_Y];
    
    UIColor *twitterBgcolor = UIColorFromHEX(0x4099FF);
    UIImage *twitterImage = [UIImage imageNamed:@"twitter"];
    
    HZLaunchView *launchView = [[HZLaunchView alloc] initWithIconImage:twitterImage backgroundColor:twitterBgcolor];
    [self.view addSubview:launchView];
    [launchView startAnimationWithDuration:3];
}



@end
