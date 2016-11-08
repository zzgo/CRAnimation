//
//  ProgressView.h
//  CRGatling
//
//  Created by I_MT on 2016/11/6.
//  Copyright © 2016年 I_MT. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 * Size： 355, 75  供参考
 */
@interface CRGatling : UIImageView
@property (nonatomic,assign)CGFloat  progress;
@property (nonatomic,assign)CGFloat  duration; //单个树叶时长
//**间隔时间,最好不要小于 1/60.0  */
@property (nonatomic,assign)CGFloat  timeInterval;

@end
