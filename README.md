# CQShuffScrollView
自定义轮播图
项目中要用到轮播图,想起以前自己写过轮播图,就将之前的代码拷贝过了直接放到项目中应用了,今天把这篇文章写在博客上,
**封装轮播图有人说可以使用UICollectionView,这种方法我没有尝试过,我使用的是利用三个UIImageView去显示,变换image实现切换图片**

*我在其中使用代理实现了点击对应图片的事件,并实现能监听当前滚动到哪一个index下*

**显现效果**

- 自动无限滚动
- 手动无限滚动
- 对应图片的点击事件
- 跟踪当前滚到第几张图片下
- 显示相对应的标题


![这里写图片描述](http://img.blog.csdn.net/20171228181355642?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY2hlbnFpYW5nYmxvY2s=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)
使用中只需简单的调用即可快速集成轮播功能

```
NSArray *array = @[@"1",@"2",@"3",@"4"];
NSArray *titleArray = @[@"这是第一个",@"这是第二个",@"这是第三个",@"这是第四个"];
CQShuffScrollView *shuff = [[CQShuffScrollView alloc]initWithFrame:CGRectMake(100, 100, 400, 300) ImageArray:array titleArray:titleArray];
shuff.delegate = self;

[self.view addSubview:shuff];
```

```
这是代理事件
- (void)CQShufflingSelectImageAtIndex:(NSInteger)index
{
NSLog(@"********%ld",index);
}

-(void)CQShufflingScrollerAtIndex:(NSUInteger)index
{
NSLog(@"********%ld",index);

}
```


