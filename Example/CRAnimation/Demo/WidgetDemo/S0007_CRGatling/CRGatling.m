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
    
    
    UIView  *_mainBgView;
    UIView  *_process1BgView;
    CAShapeLayer        *_processLayer;
    CABasicAnimation    *_processAnimation;
    CGFloat             _totalDuring;       //  0~1动画所需总时间

}
#define Multiple 2    //每次产生几个
#define totalAmount  60 //总的产生数
#define OldTime @"oldTimeKey"
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor blueColor];
    if (self) {
        
        [self setParamater];
        [self createUI];
//        [self setup];
    }
    return self;
}

- (void)setParamater
{
    _totalDuring = 4.0;
}

- (void)createUI
{
    [self createMainBgView];
    [self createProcessBgView];
    [self createProcessLayer];
    [self createSoldierImageV];
}


- (void)createMainBgView
{
    CGFloat mainBgView_width = 600.0 / 708 * self.width;
    CGFloat mainBgView_height = self.height * 0.67;
    
    _mainBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainBgView_width, mainBgView_height)];
    _mainBgView.backgroundColor = UIColorFromHEX(0xfed182);
    [self addSubview:_mainBgView];
    [_mainBgView BearSetCenterToParentViewWithAxis:kAXIS_Y];
    
    
    //  path
    //  坐标释义
    //  point1  point2
    //  point3  point4
    CGPoint point1 = CGPointMake(30.0 / 611 * _mainBgView.width, 0);
    CGPoint point2 = CGPointMake(_mainBgView.width, 0);
    CGPoint point3 = CGPointMake(0, _mainBgView.height);
    CGPoint point4 = CGPointMake(_mainBgView.width, _mainBgView.height);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:point4];
    [path addLineToPoint:point3];
    [path addLineToPoint:point1];
    
    
    //  mask shape
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    _mainBgView.layer.mask = shapeLayer;
    
}

- (void)createProcessBgView
{
    _process1BgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _mainBgView.width, _mainBgView.height * 0.8)];
    _process1BgView.backgroundColor = [UIColor clearColor];
    [_mainBgView addSubview:_process1BgView];
    [_process1BgView BearSetCenterToParentViewWithAxis:kAXIS_Y];
    
    
    //  path
    //  坐标释义
    //  point1  point2
    //  point3  point4
    CGPoint point1 = CGPointMake(47.0 / 611 * _process1BgView.width, 0);
    CGPoint point2 = CGPointMake(_process1BgView.width, 0);
    CGPoint point3 = CGPointMake(30.0 / 611 * _process1BgView.width, _process1BgView.height);
    CGPoint point4 = CGPointMake(_process1BgView.width, _process1BgView.height);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:point4];
    [path addLineToPoint:point3];
    [path addLineToPoint:point1];
    
    
    //  mask shape
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    _process1BgView.layer.mask = shapeLayer;
}

- (void)createProcessLayer
{
    UIBezierPath *processPath = [UIBezierPath bezierPath];
    [processPath moveToPoint:CGPointMake(0, _process1BgView.height / 2.0)];
    [processPath addLineToPoint:CGPointMake(_process1BgView.width, _process1BgView.height / 2.0)];
    
    _processLayer = [CAShapeLayer layer];
    _processLayer.path = processPath.CGPath;
    _processLayer.lineWidth = _process1BgView.height;
    _processLayer.strokeColor = UIColorFromHEX(0xfab140).CGColor;
    [_process1BgView.layer addSublayer:_processLayer];
    
    _processLayer.strokeEnd = 0.5;
}

- (void)createSoldierImageV
{
    CGFloat soldierImageV_width = self.height;
    
    NSMutableArray *images=[NSMutableArray array];
    for (int i=0; i<25; i++) {
        NSString *numStr=[NSString stringWithFormat:@"%02d",i];
        UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"加特林小人_000%@",numStr]];
        [images addObject:image];
    }
    soldierIV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, soldierImageV_width, soldierImageV_width)];
    soldierIV.image=[UIImage imageNamed:@"加特林小人_00000"];
    soldierIV.animationImages=images;
    soldierIV.animationRepeatCount=MAXFLOAT;
    [self addSubview:soldierIV];
    [soldierIV BearSetRelativeLayoutWithDirection:kDIR_RIGHT destinationView:nil parentRelation:YES distance:0 center:YES];
}

- (void)setProgress:(CGFloat )progress{
    if (progress>1.0||progress<0.0) {
        return;
    }
    
    differ = (int)((int)(progress*totalAmount) - (int)(OldProgress*totalAmount));//放大1000倍取整0~1000
    _progress = progress;
    
    [self processShapeLayerAnimation];
    
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
                [_process1BgView.layer insertSublayer:leafLayer below:_processLayer];
                [bottomView.layer addSublayer:leafLayer];
                CFTimeInterval currentSuperTime = [_process1BgView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
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
    }
    OldProgress = progress;
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
    self.timeInterval=0.1;
    self.duration=1.0;
}

//- (void)setProgress:(CGFloat )progress{
//    
//    if (progress>1.0||progress<0.0) {
//        return;
//    }
//    
//    differ = (int)((int)(progress*totalAmount) - (int)(OldProgress*totalAmount));//放大1000倍取整0~1000
//    _progress = progress;
//    //单个的时间
//    if (abs(differ)<1) {
//        return;
//    }
//    CGFloat perTime=self.duration/(differ-1);
//    if (perTime==INFINITY) {
//        perTime = self.duration/(totalAmount);
//    }
//    CGFloat lastTimeDelay;
//    if (differ>=0) {//+
//        [self startLoading];
//        for (int i=0; i<Multiple; i++) {
//            for (int i=0; i<differ; i++) {
//                CALayer *leafLayer = [CALayer layer];
//                leafLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"子弹"].CGImage);
//                leafLayer.bounds = CGRectMake(0, 0,10, 3.6);//10 10
//                CGPoint beginPoint;
//                switch (arc4random()%3) {
//                    case 0:
//                      beginPoint=  CGPointMake(BG_WIDTH,BG_HEIGHT*1/2.0-3);
//                        break;
//                    case 1:
//                        beginPoint=  CGPointMake(BG_WIDTH,BG_HEIGHT*1/2.0);
// 
//                        break;
//                    case 2:
//                        beginPoint=  CGPointMake(BG_WIDTH,BG_HEIGHT*1/2.0+3);
//
//                        break;
//                    default:
//                        break;
//                }
//                leafLayer.position = beginPoint;
//                [bottomView.layer addSublayer:leafLayer];
//                CFTimeInterval currentSuperTime = [bottomView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
//                lastTimeDelay=self.timeInterval*i;
//                CGFloat delay =currentSuperTime+self.timeInterval*i;
//                [self addAnimationToLayer:leafLayer andDelay:delay andIndex:i];
//                //            leafIndex+=1;
//                currentCount++;
//            }
//        }
//        //      });
//    }else{//-
//        [self stopLoading];
//#pragma mark -----'*** Collection <CALayerArray: 0x60800005f4a0> was mutated while being enumerated.'
//        [bottomView.layer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            [obj removeAllAnimations];
//        }];
//        CGRect rect =  progressView.frame;
//        rect.size.width = BG_WIDTH*progress;
//        progressView.frame = rect;
//    }
//    OldProgress = progress;
//}

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

- (void)processShapeLayerAnimation
{
    if (!_processAnimation) {
        _processAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        _processAnimation.fromValue = @0;
        _processAnimation.toValue   = @0;
        _processAnimation.fillMode  = kCAFillModeForwards;
        _processAnimation.removedOnCompletion = NO;
    }
    
    CGFloat during = _totalDuring * (self.progress - OldProgress);
    
    _processAnimation.fromValue = _processAnimation.toValue;
    _processAnimation.toValue = [NSNumber numberWithFloat:self.progress];
    _processAnimation.duration = during;
    [_processLayer addAnimation:_processAnimation forKey:@"processAnimation"];
    
}

@end
