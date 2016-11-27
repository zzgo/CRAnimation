//
//  ProgressView.m
//  CRGatling
//
//  Created by I_MT on 2016/11/6.
//  Copyright © 2016年 I_MT. All rights reserved.
//

#import "CRGatling.h"

@interface CRGatling ()<CAAnimationDelegate>

@end
@implementation CRGatling
{
    UIImageView *bottomView;
    UIImageView *progressView;
    UIImageView *soldierIV;


    CGFloat OldProgress;

     int differ;// 改变的量 放大100x倍
    CGFloat BG_X;
    CGFloat BG_Y ;
    CGFloat BG_WIDTH ;
    CGFloat BG_HEIGHT ;
    BOOL RotationDirection; //YES 顺时针 NO 逆时针
    BOOL isSuspend;
    int currentCount;

}
#define Multiple 2    //每次产生几个
#define totalAmount  60 //总的产生数
#define OldTime @"oldTimeKey"
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       [self setup];
    }
    return self;
}
-(void)setup{
    UIImageView *BacKGroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 12.5, 300, 50)];
    BacKGroundView.image=[UIImage imageNamed:@"底部"];
    [self addSubview:BacKGroundView];
   
    bottomView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 5, CGRectGetWidth(BacKGroundView.frame)-15, CGRectGetHeight(BacKGroundView.frame)-10)];
    [BacKGroundView addSubview:bottomView];
    UIImage *bottomBackImage=[UIImage imageNamed:@"进度条"];
//    bottomView.image=bottomBackImage;
    UIImageView *maskView=[[UIImageView alloc]initWithFrame:bottomView.bounds];
    maskView.image=bottomBackImage;
    bottomView.layer.mask=maskView.layer;
   
    BG_X=0;
//    BG_Y =bottomView.frame.origin.y;
    BG_Y=0;
    BG_WIDTH = bottomView.frame.size.width;
    BG_HEIGHT = bottomView.frame.size.height;


    progressView=[[UIImageView alloc]initWithFrame:bottomView.bounds];
    progressView.image=bottomBackImage;
    [bottomView addSubview:progressView];
    [self changeProgressViewWith:0];
    
    //Soldier
    NSMutableArray *images=[NSMutableArray array];
    for (int i=0; i<25; i++) {
    NSString *numStr=[NSString stringWithFormat:@"%02d",i];
        UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"加特林小人_000%@",numStr]];
        [images addObject:image];
    }
    soldierIV=[[UIImageView alloc]initWithFrame:CGRectMake(280, 0, 75, 75)];
    soldierIV.image=[UIImage imageNamed:@"加特林小人_00000"];
    soldierIV.animationImages=images;
    soldierIV.animationRepeatCount=MAXFLOAT;
    [self addSubview:soldierIV];
    [self defaultParameters];
}
-(void)defaultParameters{
    self.timeInterval=1.1;
    self.duration=1.0;
}

- (void)setProgress:(CGFloat )progress{
    if (progress>1.0||progress<0.0) {
        return;
    }
    differ = (int)((int)(progress*totalAmount) - (int)(OldProgress*totalAmount));//放大1000倍取整0~1000
    _progress = progress;
    //单个的时间
    if (abs(differ)<1) {
        return;
    }
    CGFloat perTime=self.duration/(differ-1);
    if (perTime==INFINITY) {
        perTime = self.duration/(totalAmount);
    }
    CGFloat lastTimeDelay;
    if (differ>=0) {//+
        [self startLoading];
        for (int i=0; i<Multiple; i++) {
            for (int i=0; i<differ; i++) {
                CALayer *leafLayer = [CALayer layer];
                leafLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"子弹"].CGImage);
                leafLayer.bounds = CGRectMake(0, 0,10, 3.6);//10 10
                CGPoint beginPoint;
                switch (arc4random()%3) {
                    case 0:
                      beginPoint=  CGPointMake(BG_WIDTH,BG_HEIGHT*1/2.0-3);
                        break;
                    case 1:
                        beginPoint=  CGPointMake(BG_WIDTH,BG_HEIGHT*1/2.0);
 
                        break;
                    case 2:
                        beginPoint=  CGPointMake(BG_WIDTH,BG_HEIGHT*1/2.0+3);

                        break;
                    default:
                        break;
                }
                leafLayer.position = beginPoint;
                [bottomView.layer addSublayer:leafLayer];
                CFTimeInterval currentSuperTime = [bottomView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
                lastTimeDelay=self.timeInterval*i;
                CGFloat delay =currentSuperTime+self.timeInterval*i;
                [self addAnimationToLayer:leafLayer andDelay:delay andIndex:i];
                //            leafIndex+=1;
                currentCount++;
            }
        }
        //      });
    }else{//-
        [self stopLoading];
#pragma mark -----'*** Collection <CALayerArray: 0x60800005f4a0> was mutated while being enumerated.'
        [bottomView.layer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeAllAnimations];
        }];
        CGRect rect =  progressView.frame;
        rect.size.width = BG_WIDTH*progress;
        progressView.frame = rect;
    }
    OldProgress = progress;
}
-(void)changeProgressViewWith:(CGFloat)width{
    CGRect frame=progressView.frame;
    frame.size.width=width;
    progressView.frame=frame;
}
#pragma mark -----添加动画 （树叶）
-(void)addAnimationToLayer:(CALayer *)layer andDelay:(CGFloat)delay andIndex:(int)index{
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //一直增加的话
    //进度条之前的位置
    CGFloat beginP = BG_WIDTH*OldProgress;
    CGFloat addWidth = BG_WIDTH/(1.0*totalAmount*Multiple)*(index+1);
    CGFloat teminalPosition = beginP+addWidth;
    CGFloat moveWidth = BG_WIDTH - teminalPosition;
    CGPoint originalP = CGPointMake(layer.position.x, layer.position.y);// layer.position;
    CGFloat terminalY;
    CGPoint controlPoint;
    CGPoint middlePoint;
    terminalY=originalP.y;
    CGPoint terminalPoint=CGPointMake(teminalPosition,terminalY);
    if (originalP.y==1/2.0*BG_HEIGHT+3) {
        terminalPoint.y=terminalPoint.y+5;
        middlePoint= controlPoint=   CGPointMake(1/2.0*(teminalPosition+originalP.x),terminalY+10);
    }else if (originalP.y==1/2.0*BG_HEIGHT-3){
        terminalPoint.y=terminalPoint.y-5;
        middlePoint = controlPoint=   CGPointMake(1/2.0*(teminalPosition+originalP.x),terminalY-10);
    }else{
        middlePoint = controlPoint=   CGPointMake(1/2.0*(teminalPosition+originalP.x),terminalY);
    }
    UIBezierPath *path=[UIBezierPath bezierPath];
    [path moveToPoint:originalP];
    [path addQuadCurveToPoint:terminalPoint controlPoint:controlPoint];
    #pragma mark -----todo
   keyFrameAnimation.path=path.CGPath;
    if (isnan(delay)) {
        return;
    }
    //动画持续时间
    //    group.duration = self.duration;
    keyFrameAnimation.duration=moveWidth/BG_WIDTH*self.duration;
    keyFrameAnimation.delegate = self;
//    keyFrameAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    keyFrameAnimation.beginTime=delay;
    [keyFrameAnimation setValue:layer forKey:@"leafLayer"];
    [layer addAnimation:keyFrameAnimation forKey:@"move"];
}

#pragma mark ----- Animation Delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    CALayer *layer = [anim valueForKey:@"leafLayer"];
    [layer removeFromSuperlayer];
    if (flag) {
        CGRect rect = progressView.frame;
        CGFloat currentWidth=rect.size.width;
        CGFloat perAddWidth= BG_WIDTH/(totalAmount*Multiple*1.0);
        currentWidth += perAddWidth;
        rect.size.width=currentWidth;
        progressView.frame = rect;
        //误差
        currentWidth=rect.size.width;
        CGFloat destinationWidth=BG_WIDTH*self.progress;
        if (fabs(destinationWidth-currentWidth)<=Multiple*perAddWidth) {//...
            [self stopLoading];
        }
    }
}
- (void)startLoading{
    if (RotationDirection==YES) {
        return;
    }
    RotationDirection=YES;

    [soldierIV startAnimating];

}
- (void)stopLoading{
    if (RotationDirection==NO) {
        return;
    }
    RotationDirection=NO;
    [soldierIV stopAnimating];
}

@end
