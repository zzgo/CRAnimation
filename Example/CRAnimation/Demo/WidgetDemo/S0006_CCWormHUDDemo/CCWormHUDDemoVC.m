//
//  CCWormHUDDemoVC.m
//  CRAnimation
//
//  Created by Cocos on 2016/11/7.
//  Copyright © 2016年 Cocos. All rights reserved.
//

#import "CCWormHUDDemoVC.h"
#import <CRAnimation/CCWormView.h>

@interface CCWormHUDDemoVC ()
@property (nonatomic,strong) CCWormView *ccView;
@end

@implementation CCWormHUDDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    CCWormView *wormView = [CCWormView wormHUDWithStyle:CCWormHUDStyleLarge toView:self.view];
    self.ccView = wormView;
    [self addTopBar];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.ccView startLodingWormHUD];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.ccView endLodingWormHUD];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
