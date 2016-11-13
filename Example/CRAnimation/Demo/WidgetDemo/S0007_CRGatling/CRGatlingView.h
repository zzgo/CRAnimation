//
//  CRGatlingView.h
//  CRAnimation
//
//  Created by apple on 16/11/13.
//  Copyright © 2016年 BearRan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRGatlingView : UIView

@property (nonatomic,assign)CGFloat  progress;
@property (nonatomic,assign)CGFloat  duration; //单个树叶时长
//**间隔时间,最好不要小于 1/60.0  */
@property (nonatomic,assign)CGFloat  timeInterval;

@end
