//
//  CRGatlingVC.m
//  CRAnimation
//
//  Created by I_MT on 2016/11/8.
//  Copyright © 2016年 BearRan. All rights reserved.
//

#import "CRGatlingVC.h"
#import "CRGatling.h"
@interface CRGatlingVC ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@implementation CRGatlingVC
{
    CRGatling *progressView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    progressView=[[CRGatling alloc]initWithFrame:CGRectMake(5, 50, 355, 75)];
    [self.view addSubview:progressView];
}
- (IBAction)okSet:(UIButton *)sender {
    [progressView setProgress:[self.textField.text floatValue]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
