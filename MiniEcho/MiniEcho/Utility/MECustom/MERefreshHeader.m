//
//  MERefreshHeader.m
//  MiniEcho
//
//  Created by vcredit on 16/11/22.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "MERefreshHeader.h"
#import "UIImage+GIF.h"
@interface MERefreshHeader ()

@property (nonatomic,strong) UIImageView *gifImagView;
@property (nonatomic,strong) NSArray *animationArray;
@end


@implementation MERefreshHeader

- (void)prepare {

    [super prepare];
    self.mj_h = 75;
    UIImageView *imageView = [[UIImageView alloc] init];
//    imageView.backgroundColor = [UIColor yellowColor];
    [self addSubview:imageView];
    _gifImagView = imageView;
}

- (void)placeSubviews {

    [super placeSubviews];
    self.gifImagView.bounds = CGRectMake(0, 0, 200, 75);
    self.gifImagView.center = CGPointMake(self.mj_w * 0.5, self.mj_h - 38);
    
}
#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}
- (void)setState:(MJRefreshState)state {

    MJRefreshCheckState;
    switch (state) {
        case MJRefreshStateIdle:
            NSLog(@"普通闲置状态");
            [self endAnimation];
            break;
        case MJRefreshStatePulling:
            NSLog(@"松开就可以进行刷新的状态");
            [self endAnimation];
            break;
        case MJRefreshStateRefreshing:
            NSLog(@"正在刷新中的状态");
            [self startAnimation];
            break;
        default:
            break;
    }
}
#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    if (pullingPercent > 1 || pullingPercent < 0) {
        return;
    }
    NSInteger index = [self.animationArray count] * pullingPercent;
    NSLog(@"index =%ld",index);
    if (index == [self.animationArray count]) {
        index = [self.animationArray count] - 1;
    }
    [self.gifImagView setImage:[self.animationArray safeObjectAtIndex:index] ];
    NSLog(@"pull =%f",pullingPercent);
}
- (void)startAnimation {

    NSString  *name = @"headerloading.gif";
    
    NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:name ofType:nil];
    
    NSData  *imageData = [NSData dataWithContentsOfFile:filePath];

    self.gifImagView.image = [UIImage sd_animatedGIFWithData:imageData];

}
- (void)endAnimation {

    [self.gifImagView stopAnimating];
}
- (NSArray *)animationArray {

    if (!_animationArray) {
        NSMutableArray *animationArray = [NSMutableArray array];
        for (int i = 0 ; i <15 ; i++) {
            NSString *name = [NSString stringWithFormat:@"refresh_000%.2d",i];
            NSLog(@"%@",name);
            UIImage *aimage = [UIImage imageNamed:name];
            [animationArray safeAddObject:aimage];
        }
        _animationArray = [NSArray arrayWithArray:animationArray];
    }
    return _animationArray;
}
@end
