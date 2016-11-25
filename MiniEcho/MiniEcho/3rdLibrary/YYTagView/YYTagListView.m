//
//  YYTagListView.m
//  YYTagViewDemo
//
//  Created by 胡阳 on 2016/11/20.
//  Copyright © 2016年 young4ever. All rights reserved.
//

#import "YYTag.h"
#import "YYTagListView.h"
#import "YYTagViewLayout.h"

@interface YYTagListView ()

@property (nonatomic, strong) YYTagViewLayout *layout;

@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, strong) NSMutableArray  *tagArray;

@end

@implementation YYTagListView

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame WithLayout:(YYTagViewLayout *)layout
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _layout = layout;
        _selectedIndex = -1;
    }
    return self;
}

#pragma mark - Set Tags

- (void)addYYTags:(NSArray *)tags
{
    __weak typeof(self) weakSelf = self;
    
    for (NSInteger i=0; i < tags.count; i++) {
        NSString *title = tags[i];
        
        CGFloat currentTagWidth = [self tagViewWidthWithTitle:title fontSize:14.f];
        CGRect frame = CGRectMake(0.f, 0.f, currentTagWidth, self.layout.itemHeight);
        
        YYTagView *tagView = [[YYTagView alloc] initWithFrame:frame];
        tagView.title = title;
        tagView.index = i;
        tagView.radius = 5.f;
        tagView.fontSize = 14.f;
        tagView.titleColor = self.tintColor;
        tagView.action = ^(NSInteger index){
            [weakSelf didTapTagViewAtIndex:index];
        };
        [self.tagArray addObject:tagView];
    }
    [self arrangeTagViews];
    [self didTapTagViewAtIndex:0];
}

- (void)arrangeTagViews
{
    [self.subviews enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    __block float maxY = self.layout.contentInset.top + self.layout.verticalSpace;
    __block float maxX = self.layout.contentInset.left;
    __block CGSize size = CGSizeZero;
    for (YYTagView *obj in self.tagArray) {
        size = obj.frame.size;
        [self.subviews enumerateObjectsUsingBlock:^(UIView* view, NSUInteger idx, BOOL *stop) {
            if ([view isKindOfClass:[YYTagView class]]) {
                maxY = MAX(maxY, view.frame.origin.y);
            }
        }];
        
        [self.subviews enumerateObjectsUsingBlock:^(UIView* view, NSUInteger idx, BOOL *stop) {
            if ([view isKindOfClass:[YYTagView class]]) {
                if (view.frame.origin.y == maxY) {
                    maxX = MAX(maxX, view.frame.origin.x + view.frame.size.width);
                }
            }
        }];
        
        // 换行
        if (size.width + maxX > (self.frame.size.width - self.layout.contentInset.right)) {
            maxY += size.height + self.layout.verticalSpace;
            maxX = self.layout.contentInset.left;
        }
        obj.frame = CGRectMake(maxX + self.layout.horizontalSpace, maxY, size.width, size.height);
        [self addSubview:obj];
    };
}
#pragma mark - Action

- (void)didTapTagViewAtIndex:(NSInteger)index
{
    [self.subviews enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL *stop) {
        YYTagView *tagView = (YYTagView *)obj;
        if (index == idx) {
            tagView.backgroundColor = self.tintColor;
            tagView.titleColor = [UIColor whiteColor];
        } else {
            tagView.backgroundColor = [UIColor whiteColor];
            tagView.titleColor = self.tintColor;
        }
    }];
    
    NSLog(@"~~~~~~~%zd~~~~~~~",index);
}

#pragma mark - Util

- (CGFloat)tagViewWidthWithTitle:(NSString *)title fontSize:(CGFloat)fontSize
{
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    NSInteger options = NSStringDrawingUsesFontLeading |
    NSStringDrawingTruncatesLastVisibleLine |
    NSStringDrawingUsesLineFragmentOrigin;
    CGRect stringRect = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, _layout.itemHeight) options:options attributes:attributes context:NULL];
    CGFloat tagWidth = stringRect.size.width + 10.f;
    return MAX(tagWidth, 50.f);
}

#pragma mark - Lazy Load

- (NSMutableArray *)tagArray
{
    if (!_tagArray) {
        _tagArray = [NSMutableArray array];
    }
    return _tagArray;
}



@end
