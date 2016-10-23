##简介：
图片渐变切换效果

| demo信息    | 详情                  |
|:-----------:|:---------------------:|
| DemoName    | CRImageGradientView   |
| CRID        | S0002                 |
| author      | Bear                  |
| authorMail  | 648070256@qq.com      |
| 源gitHub    | 无                    |
| 其他说明    | 无                    |


---
##使用：
>pod ‘CRAnimation/Widget/CRImageGradientView’

```
// init
CRImageGradientView *imageGradientView = [[CRImageGradientView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
[self.view addSubview:imageGradientView];

// setNextImage
[imageGradientView setNextImageName:@"TestImage_1"];
```

## 属性列表
```
// animationDuration_EX：图片切换间隔时间，默认0.3s
imageGradientView.animationDuration_EX = 1.0f;
```
---
## 演示效果：
![CRImageGradientDemoVC.gif](CRImageGradientDemoVC.gif)
