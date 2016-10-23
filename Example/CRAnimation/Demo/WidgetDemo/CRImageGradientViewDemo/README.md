# CRImageGradientViewDemo

简介：图片渐变切换效果

DemoName:CRImageGradientView

CRID：S0002

作者：Bear

作者邮箱：648070256@qq.com

源gitHub地址：无

其他说明文档地址：无


---
##集成方法：

`pod ‘CRAnimation/Widget/CRImageGradientView’`


### 最快使用方法
```
//  init
CRImageGradientView *imageGradientView = [[CRImageGradientView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
[self.view addSubview:imageGradientView];

//  setNextImage
[imageGradientView setNextImageName:@"TestImage_1"];

```

### 其他可配置参数
```
//  animationDuration_EX：图片切换间隔时间，默认0.3s
imageGradientView.animationDuration_EX = 1.0f;
```


---
## 演示效果：

![CRImageGradientDemoVC.gif](CRImageGradientDemoVC.gif)
