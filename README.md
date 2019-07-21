###目录
* [**前言**](#前言)
* [**区别**](#区别)
* [**事件响应链条**](#用法)
* [**总结**](#总结)
* [**修复记录**](#修复记录)


### <a name="前言"></a>前言
在使用UICollectionViewFlowLayout 布局时发现一个问题：无法固定间距。所以我继承UICollectionViewFlowLayout写了一个类：YHRegularLayout。

### <a name="区别"></a>区别
YHRegularLayout 是一种固定行 和 列间距的layout。
无图无真相，看了图就明白他们之间的区别了

####**UICollectionViewFlowLayout**
![UICollectionViewFlowLayout.jpeg](http://upload-images.jianshu.io/upload_images/1891685-73c61deb5948fd53.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

####**YHRegularLayout**
![YHRegularLayout.jpeg](http://upload-images.jianshu.io/upload_images/1891685-0cff49b93ae74e19.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

很明显，UICollectionViewFlowLayout 在无法刚好充满屏幕时对该行的间距进行调整，使首尾刚好贴着两边。YHRegularLayout则反之，不调整间距，直接换行。

### <a name="用法"></a>用法
正常使用即可，只是把设定的值，改 “最小” 为 “固定”，如下。

```
YHRegularLayout *flow=[[YHRegularLayout alloc]init];
flow.minimumInteritemSpacing=10;
flow.minimumLineSpacing=10;
flow.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);

UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];

```

### <a name="总结"></a>总结
[GitHub地址](https://github.com/developeryh/YHRegularLayout)

### <a name="修复记录"></a>修复记录
2019.7.21 (ps:感谢 @XiFengLang、@sdlbp 提的建议)
1.修复不左对称问题
2.修复单个label超出屏幕的情况
3.基础数据类型被错误转换的问题

