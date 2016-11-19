//
//  CRGatlingView.m
//  CRAnimation
//
//  Created by apple on 16/11/13.
//  Copyright © 2016年 BearRan. All rights reserved.
//

#import "CRGatlingView.h"

@interface CRGatlingView () <CAAnimationDelegate>

@end

@implementation CRGatlingView
{
    UIImageView         *soldierIV;
    UIView              *_mainBgView;
    UIView              *_process1BgView;
    CAShapeLayer        *_processLayer;
    CABasicAnimation    *_processAnimation;
    
    CGFloat             OldProgress;
    CGFloat             BG_WIDTH ;
    CGFloat             BG_HEIGHT ;
    CGFloat             _processTotalDuring;        //  0~1动画所需总时间
    CGFloat             _bulletTotalDuring;         //  子弹走完全程所需时间
    CGFloat             _bulletTimeGap;             //  发射子弹的时间间隔
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor blueColor];
    if (self) {
        
        [self setParamater];
        [self createUI];
    }
    return self;
}

- (void)setParamater
{
    _processTotalDuring = 4.0;
    _bulletTotalDuring = 4.0;
    _bulletTimeGap = 0.2;
}


#pragma mark - CreateUI

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
    
    BG_WIDTH = _process1BgView.width;
    BG_HEIGHT = _process1BgView.height;
}

- (void)createProcessLayer
{
    UIBezierPath *processPath = [UIBezierPath bezierPath];
    [processPath moveToPoint:CGPointMake(0, _process1BgView.height / 2.0)];
    [processPath addLineToPoint:CGPointMake(_process1BgView.width, _process1BgView.height / 2.0)];
    
    _processLayer = [CAShapeLayer layer];
    _processLayer.path = processPath.CGPath;
    _processLayer.lineWidth = _process1BgView.height;
    _processLayer.strokeColor = [UIColorFromHEX(0xfab140) colorWithAlphaComponent:0.3].CGColor;
    [_process1BgView.layer addSublayer:_processLayer];
    
    _processLayer.strokeEnd = 0;
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


#pragma mark - Rewrite

- (void)setProgress:(CGFloat )progress{
    
    if (progress>1.0||progress<0.0) {
        return;
    }
    
    _progress = progress;
    
    [self bulletAnimationManager];
    
    OldProgress = _progress;
}


#pragma mark - 添加动画 （子弹）

- (void)bulletAnimationManager
{
    //  本次进度条动画所需时间
    CGFloat thisProcessTime         = _processTotalDuring * (_progress - OldProgress);
    //  进度条延时执行时间
    CGFloat processDelayTime        = 0;
    
    //  第一颗子弹所需时间
    CGFloat firstBulletTime = [self addBulletAnimationWithProcess:OldProgress oldProcess:OldProgress animation:NO bulletDelayTime:0];
    //  最后一颗子弹所需时间
    CGFloat lastBulletTime = [self addBulletAnimationWithProcess:_progress oldProcess:OldProgress animation:NO bulletDelayTime:0];
    //  进度条动画延时时间
    CGFloat progressDelay = firstBulletTime;
    //  动画总时间
    CGFloat TotalTime = progressDelay + thisProcessTime;
    
    //  子弹总数
    int totalBulletCount = 1.0 * (TotalTime - lastBulletTime) / _bulletTimeGap;
    CGFloat oldProgress = OldProgress;
    
    for (int i = 0; i < totalBulletCount; i++) {
        
        //  当前子弹所在percent
        CGFloat bulletPercent   = 1.0 * i / totalBulletCount;
        //  预计算本次对应进度条的progress
        CGFloat thisProgress    = OldProgress + (_progress - OldProgress) * bulletPercent;
        //  子弹延时时间
        CGFloat bulletDelay     = i * _bulletTimeGap;
        
        [self addBulletAnimationWithProcess:thisProgress oldProcess:oldProgress animation:YES bulletDelayTime:bulletDelay];
        oldProgress = thisProgress;
    }
    
    processDelayTime = firstBulletTime;
    //  进度条动画
    [self processShapeLayerAnimationWithDuring:thisProcessTime delay:processDelayTime];
}

-(CGFloat)addBulletAnimationWithProcess:(CGFloat)process oldProcess:(CGFloat)oldProcess animation:(BOOL)animation bulletDelayTime:(CGFloat)bulletDelayTime{
    
    //  进度条总路程
    CGFloat processTotalDistance    = _process1BgView.width;
    //  子弹宽度
    CGFloat bulletWidth             = 10;
    //  子弹总路程
    CGFloat bulletTotalDistance     = _process1BgView.width;
    //  本次子弹需要走过的路程
    CGFloat thisBulletDistance      = processTotalDistance * (1 - process) + bulletWidth / 2.0;
    //  本次子弹所需时间
    CGFloat thisBulletTime          = (1.0 * thisBulletDistance / bulletTotalDistance) * _bulletTotalDuring;
    
    if (animation) {
        //  子弹动画
        [self addBulleLayerAnimationWithBulletTotalDistance:bulletTotalDistance
                                         thisBulletDistance:thisBulletDistance
                                             thisBulletTime:thisBulletTime
                                            bulletDelayTime:bulletDelayTime];
    }
    
    return thisBulletTime;
}

- (void)addBulleLayerAnimationWithBulletTotalDistance:(CGFloat)bulletTotalDistance
                                   thisBulletDistance:(CGFloat)thisBulletDistance
                                       thisBulletTime:(CGFloat)thisBulletTime
                                      bulletDelayTime:(CGFloat)bulletDelayTime
{
    CALayer *bulletLayer = [CALayer layer];
    bulletLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"子弹"].CGImage);
    bulletLayer.bounds = CGRectMake(0, 0,10, 3.6);//10 10
    
    [_process1BgView.layer insertSublayer:bulletLayer below:_processLayer];
    CFTimeInterval currentSuperTime0 = [_process1BgView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    CGFloat delay = currentSuperTime0;
    
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
    bulletLayer.position = beginPoint;
    
    //  子弹动画
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //一直增加的话
    //进度条之前的位置
    CGFloat teminalPosition = bulletTotalDistance - thisBulletDistance;
    CGPoint originalP = CGPointMake(bulletLayer.position.x, bulletLayer.position.y);// layer.position;
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
    
    keyFrameAnimation.path=path.CGPath;
    if (isnan(delay)) {
        return;
    }
    
    //动画持续时间
    keyFrameAnimation.duration = thisBulletTime;
    
#warning DAD
    keyFrameAnimation.removedOnCompletion = NO;
    keyFrameAnimation.fillMode = kCAFillModeForwards;
    
#warning Release
    //    keyFrameAnimation.delegate = self;
    
    CFTimeInterval currentSuperTime = [_process1BgView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    keyFrameAnimation.beginTime = currentSuperTime + bulletDelayTime;
    [keyFrameAnimation setValue:bulletLayer forKey:@"leafLayer"];
    [bulletLayer addAnimation:keyFrameAnimation forKey:@"move"];
}


#pragma mark ----- Animation Delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    CALayer *layer = [anim valueForKey:@"leafLayer"];
    [layer removeFromSuperlayer];
}

- (void)startLoading{
    [soldierIV startAnimating];
}

- (void)stopLoading{
    [soldierIV stopAnimating];
}

- (void)processShapeLayerAnimationWithDuring:(CGFloat)during delay:(CGFloat)delay
{
    if (!_processAnimation) {
        _processAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        _processAnimation.fromValue = @0;
        _processAnimation.toValue   = @0;
        _processAnimation.fillMode  = kCAFillModeForwards;
        _processAnimation.removedOnCompletion = NO;
    }
    
    CFTimeInterval currentSuperTime = [_process1BgView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    delay += currentSuperTime;
    
    _processAnimation.fromValue = _processAnimation.toValue;
    _processAnimation.toValue = [NSNumber numberWithFloat:self.progress];
    _processAnimation.duration = during;
    _processAnimation.beginTime = delay;
    [_processLayer addAnimation:_processAnimation forKey:@"processAnimation"];
    
}

@end
