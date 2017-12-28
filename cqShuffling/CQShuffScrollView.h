//
//  CQShuffScrollView.h
//  cqShuffling
//
//  Created by chenq@kensence.com on 2016/12/01.
//  Copyright © 2016年 chenq@kensence.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@protocol CQShuffScrollViewDelegate<NSObject>
- (void)CQShufflingSelectImageAtIndex:(NSInteger)index;
- (void)CQShufflingScrollerAtIndex:(NSUInteger)index;
@end



@interface CQShuffScrollView : UIView

/**分页控制器颜色 */
@property (nonatomic ,strong)UIColor  *PageControlColor;

/**分页控制器默认正常状态下颜色 */
@property (nonatomic ,strong)UIColor  *PageControlNomarColor;

/**分页控制器选中颜色*/
@property (nonatomic ,strong)UIColor  *PageControlSeleColor;

/**分页控制器原点大小*/
@property (nonatomic ,assign)CGFloat  pageControlSize;

/**控制器原点的间隔 */
@property (nonatomic ,assign)CGFloat  PageSpacWidth;

/**标题文字颜色 */
@property (nonatomic ,strong)UIColor   *TitleColor;

/**标题文字大小 */
@property (nonatomic ,assign)CGFloat    TitleFont;

@property (nonatomic ,assign)NSTextAlignment       TextAlignment;
@property (nonatomic ,strong)NSArray                *titles;
//是否竖向滚动
@property (nonatomic, assign, getter=isScrollDorectionPortrait) BOOL scrollDorectionPortrait;



@property (nonatomic ,weak)id<CQShuffScrollViewDelegate>delegate;

- (instancetype )initWithFrame:(CGRect)frame ImageArray:(NSArray *)imageArray titleArray:(NSArray *)titles;



@end
