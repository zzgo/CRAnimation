[TOC]

# S0005_HZLaunchView
<img src="http://oftcdgt2m.bkt.clouddn.com/S0005/HZLaunchView.gif" width=200 />

##简介：
HZLaunchVies，用CAAnimation写的Launch动画，供大家学习交流使用，已封装好也可以用到项目里面当Launch动画

| demo信息    | 详情                      |
|:-----------:|:--------------------------|
| DemoName    | HZLaunchView            |
| CRID        | S0005                     |
| author      | [zzgo](https://github.com/zzgo) |
| authorMail  | zzgocc@gmail.com |
| 源gitHub    | https://github.com/zzgo/TwitterLaunchDemo |
| 其他说明    | 暂无 |

## 使用：

导入`HZLaunchView.h`

```
//初始化
HZLaunchView *launchView=[[HZLaunchView alloc] initWithIconImage:[UIImage imageNamed:kTwitterImageName] backgroundColor:color];

//指定动画时间,启用动画
[launchView startAnimationWithDuration:3];
```



