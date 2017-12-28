//
//  CQShuffScrollView.m
//  cqShuffling
//
//  Created by chenq@kensence.com on 2016/12/01.
//  Copyright © 2016年 chenq@kensence.com. All rights reserved.
//

#import "CQShuffScrollView.h"

#define Height self.frame.size.height
#define Width self.frame.size.width

static const int imageCount = 3;

@interface CQShuffScrollView()<UIScrollViewDelegate>
@property (nonatomic ,strong)UIScrollView               *scroller;
@property (nonatomic ,strong)UIPageControl              *pageControl;
@property (nonatomic ,strong)NSTimer                    *timer;
@property (nonatomic ,strong)NSArray*                   ImageArray; //图片数组
@property (nonatomic ,assign)NSInteger                  ScrollerIndex; //当前滚动到第几个
@property (nonatomic ,assign)CGFloat                    bottomHeight; //pageControl 距离底部的高度
@property (nonatomic ,strong)UILabel                    *TitleLabel;//titleColor


@end
@implementation CQShuffScrollView


- (instancetype )initWithFrame:(CGRect)frame ImageArray:(NSArray *)imageArray titleArray:(NSArray *)titles
{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        self.titles = titles;
        [self itemDefaultProrperty];
        [self DrawViewWithImageArray:imageArray];
    }
    return self;
}

/**
 属性设置
 */
- (void)itemDefaultProrperty
{
    _pageControlSize = 20;
    _PageSpacWidth = 15;
    _PageControlColor = [UIColor orangeColor];
    _PageControlSeleColor = [UIColor blackColor];
    _PageControlNomarColor = [UIColor cyanColor];
    _TitleColor = [UIColor blackColor];
    _TitleFont = 15;
    _TextAlignment = NSTextAlignmentCenter;
    _bottomHeight = 25;
}


- (void)DrawViewWithImageArray:(NSArray *)array
{
    if (array.count > 0) {
        self.ImageArray = array;
        _scroller = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scroller.contentSize = CGSizeMake(self.frame.size.width * array.count, self.frame.size.height);
        _scroller.backgroundColor = [UIColor whiteColor];
        _scroller.pagingEnabled = YES;
        _scroller.showsHorizontalScrollIndicator = NO;
        _scroller.delegate = self;
        [self addSubview:_scroller];
   
    for (int i = 0; i < imageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0 + Width * i, 0, Width, Height)];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [imageView addGestureRecognizer:tap];
        [_scroller addSubview:imageView];
        
        _TitleLabel = [[UILabel alloc]initWithFrame:CGRectMake     (0, CGRectGetMaxY(imageView.frame) - 45, Width, 25)];
        _TitleLabel.textColor = _TitleColor;
        _TitleLabel.font = [UIFont systemFontOfSize:_TitleFont];
        _TitleLabel.textAlignment = _TextAlignment;
        [imageView addSubview:_TitleLabel];
    }
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.frame = CGRectMake(Width / 2 - 50, Height - _bottomHeight, 100, _pageControlSize);
        _pageControl.numberOfPages = array.count;
        _pageControl.currentPage = 0;
        _pageControl.pageIndicatorTintColor = _PageControlNomarColor; //非选中
        _pageControl.currentPageIndicatorTintColor = _PageControlSeleColor; //选中
        [self addSubview:_pageControl];
        _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(ScrollerAction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
        [self setContent];
    }
    
}

- (void)starTime{
    [self.timer setFireDate:[NSDate dateWithTimeInterval:2.5 sinceDate:[NSDate date]]];
}

- (void)stopTimer{
    [self.timer setFireDate:[NSDate distantFuture]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.isScrollDorectionPortrait) {
        self.scroller.contentSize = CGSizeMake(Width, Height * imageCount);
        self.scroller.contentOffset = CGPointMake(0, Height);
    }else
    {
        self.scroller.contentSize = CGSizeMake(Width * imageCount, Height);
        self.scroller.contentOffset = CGPointMake(Width, 0);
    }

}
- (void)setContent
{
    for (int i = 0; i < self.scroller.subviews.count; i++) {
        UIImageView *imageView = self.scroller.subviews[i];
        NSInteger index = self.pageControl.currentPage;
        if (i == 0) {
            index--;
        }else if (i == 2)
        {
            index++;
        }
        if (index < 0) {
            index = self.pageControl.numberOfPages - 1;
        }else if(index == self.pageControl.numberOfPages){
            index = 0;
        }
        
        imageView.tag = index;
        
        NSString *string = [NSString stringWithFormat:@"%@",self.ImageArray[index]];
        if (string.length > 4 && [[string substringToIndex:3] isEqualToString:@"htt"]) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.ImageArray[index]]];
        }else
        {
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.ImageArray[index]]];
        }
    
        if (_titles.count > 0) {
            
            for (UILabel  *titleLabel in imageView.subviews) {
                titleLabel.text = [NSString stringWithFormat:@"%@",_titles[_pageControl.currentPage]];
            }
        }
        
        _ScrollerIndex = index;
    }
}

- (void)updataContent
{
    [self setContent];
    if (self.isScrollDorectionPortrait) {
        self.scroller.contentOffset = CGPointMake(0, Height);
    }else
    {
        self.scroller.contentOffset = CGPointMake(Width, 0);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger page = 0;
    CGFloat minDistance = MAXFLOAT;
    for (int i = 0; i < self.scroller.subviews.count; i++) {
        UIImageView *imageView = self.scroller.subviews[i];
        CGFloat distance = 0;
        if (self.isScrollDorectionPortrait) {
            distance = ABS(imageView.frame.origin.y - scrollView.contentOffset.y);
        }else
        {
            distance = ABS(imageView.frame.origin.x - scrollView.contentOffset.x);
        }
        if (distance < minDistance) {
            minDistance = distance;
            page = imageView.tag;
        }
    }
    
    self.pageControl.currentPage = page;
  
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

//结束拖拽的时候更新image内容
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updataContent];
    if ([_delegate respondsToSelector:@selector(CQShufflingScrollerAtIndex:)]) {
        [_delegate CQShufflingScrollerAtIndex:_pageControl.currentPage];
    }
    [self starTime];
    
}

//scroll滚动动画结束的时候更新image内容
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self updataContent];
    if ([_delegate respondsToSelector:@selector(CQShufflingScrollerAtIndex:)]) {
        [_delegate CQShufflingScrollerAtIndex:_pageControl.currentPage];
    }
}

- (void)ScrollerAction
{
    if (self.isScrollDorectionPortrait) {
        [self.scroller setContentOffset:CGPointMake(0, 2 * Height) animated:YES];
    } else {
        [self.scroller setContentOffset:CGPointMake(2 * Width, 0) animated:YES];
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    if (tap.state == UIGestureRecognizerStateBegan) {
        [self stopTimer];
    }else if (tap.state == UIGestureRecognizerStateEnded)
    {
        [self starTime];
        if ([_delegate respondsToSelector:@selector(CQShufflingSelectImageAtIndex:)]) {
            [_delegate CQShufflingSelectImageAtIndex:tap.view.tag];
        }
    }
    
}

- (void)setTitleColor:(UIColor *)TitleColor
{
    _TitleLabel.textColor = TitleColor;
}

- (void)setPageControlSeleColor:(UIColor *)PageControlSeleColor
{
    _pageControl.currentPageIndicatorTintColor = PageControlSeleColor;
}

-(void)setPageControlNomarColor:(UIColor *)PageControlNomarColor
{
     _pageControl.pageIndicatorTintColor = PageControlNomarColor;
}


-(void)setTitleFont:(CGFloat)TitleFont
{
    _TitleLabel.font = [UIFont systemFontOfSize:TitleFont];
}


@end
