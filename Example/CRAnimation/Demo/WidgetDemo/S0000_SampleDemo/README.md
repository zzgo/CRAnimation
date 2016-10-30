# S0000_SampleDemo
<img src="https://camo.githubusercontent.com/a6eec93a26efa4b006ccddafcc132871e6a8a514/687474703a2f2f696d672e626c6f672e6373646e2e6e65742f3230313630393038313632333236353330" width=200 />

##简介：
测试动效

| demo信息    | 详情                                                      |
|:-----------:|:---------------------------------------------------------:|
| DemoName    | CRSampleAnimationView                                     |
| CRID        | S0000                                                     |
| author      | [Bear](https://github.com/BearRan)                        |
| authorMail  | 648070256@qq.com                                          |
| 源gitHub    | [https://github.com/BearRan](https://github.com/BearRan)  |
| 其他说明     | [https://github.com/BearRan](https://github.com/BearRan)  |

##使用：

###Pod
>pod ‘CRAnimation/Widget/CRSampleDemoView’

```
//  init
CRCardAnimationView *cardAnimationView = [[CRCardAnimationView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
cardAnimationView.delegate = self;
cardAnimationView.cardShowInView_Count = 3;
[self.view addSubview:_cardAnimationView];
```

###代理方法
```
//  显示的card数量，和tableView中的numberOfRows同理
- (NSInteger)numberOfCardsInCardAnimationView:(CRCardAnimationView *)cardAnimationView
{
return 10;
}
```

## 属性列表
```
CGFloat   animationDuration_Normal;   //普通动画时间
int       cardShowInView_Count;       //可见的卡片数量
CGFloat   cardAlphaGapValue;          //相邻卡片alpha差值
CGPoint   cardOffSetPoint;            //相邻卡片偏移位置设定
CGFloat   cardScaleRatio;             //相邻卡片缩放比例
```
