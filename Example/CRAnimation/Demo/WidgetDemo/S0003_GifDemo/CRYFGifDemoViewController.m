//
//  CRYFGifDemoViewController.m
//  CRAnimation
//
//  Created by Bear on 16/10/12.
//  Copyright © 2016年 BearRan. All rights reserved.
//

#import "CRYFGifDemoViewController.h"
#import "YLImageView.h"
#import "YLGIFImage.h"

@interface CRYFGifDemoViewController ()

@end

@implementation CRYFGifDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    [self addTopBar];
}

- (void)createUI
{
    YLImageView* imageView = [[YLImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    [self.view addSubview:imageView];
    imageView.image = [YLGIFImage imageNamed:@"CardFlipGif.gif"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
