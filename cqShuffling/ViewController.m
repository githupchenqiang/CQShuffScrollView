//
//  ViewController.m
//  cqShuffling
//
//  Created by chenq@kensence.com on 2016/12/01.
//  Copyright © 2016年 chenq@kensence.com. All rights reserved.
//

#import "ViewController.h"
#import "CQShuffScrollView.h"
@interface ViewController ()<CQShuffScrollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *array = @[@"1",@"2",@"3",@"4"];
    NSArray *titleArray = @[@"这是第一个",@"这是第二个",@"这是第三个",@"这是第四个"];
    CQShuffScrollView *shuff = [[CQShuffScrollView alloc]initWithFrame:CGRectMake(100, 100, 400, 300) ImageArray:array titleArray:titleArray];
    shuff.delegate = self;
    
    [self.view addSubview:shuff];
}

- (void)CQShufflingSelectImageAtIndex:(NSInteger)index
{
    NSLog(@"********%ld",index);
}

-(void)CQShufflingScrollerAtIndex:(NSUInteger)index
{
    NSLog(@"********%ld",index);

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
