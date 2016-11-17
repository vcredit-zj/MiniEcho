//
//  NavigationTitleView.m
//  NavigationTitleView
//
//  Created by fantasy on 16/2/25.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "NavigationTitleView.h"

#define  WKFColor(a,b,c,d) [UIColor colorWithRed:(a)/255. green:(b)/255. blue:(c)/255. alpha:(d)]

/**
 * default Color and Font
 */
#define defaultColor WKFColor(81, 81, 81, 1)
#define defaultFont  [UIFont systemFontOfSize:17]

#define labelMargin  20

@interface NavigationTitleView ()<UIScrollViewDelegate>

@property (weak, nonatomic) UILabel * lableFirst;
@property (weak, nonatomic) UILabel * lableSecond;
@property (weak, nonatomic) UIView * containerView;

@property (strong, nonatomic) UIFont * titleFont;
@property (strong, nonatomic) UIColor * titleColor;

@end

@implementation NavigationTitleView

- (instancetype)initWithFrame:(CGRect)frame Text:(NSString *)text{
  
  return [self initWithFrame:frame Text:text andTitleFont:nil];
  
}

- (instancetype)initWithFrame:(CGRect)frame Text:(NSString *)text andTitleFont:(UIFont *)font{

  return [self initWithFrame:frame Text:text andTitleFont:font andTitleColor:nil];
  
}

- (instancetype)initWithFrame:(CGRect)frame Text:(NSString *)text andTitleFont:(UIFont *)font andTitleColor:(UIColor *)color{

  if (self = [super initWithFrame:frame]) {
    
    self.clipsToBounds = YES;
    self.userInteractionEnabled = NO;
    
    [self setupChildViewFrame:frame Text:text andTitleFont:font andTitleColor:color];
    
  }
  return self;
  
}

- (void)updateText:(NSString *)text andTitleFont:(UIFont *)font andTitleColor:(UIColor *)color{
  
  self.titleFont = font ? font : self.titleFont;
  self.titleColor = color ? color : self.titleColor;
  _lableSecond.text = text;
  _lableFirst.text = text;
  
  _lableFirst.textColor = color;
  _lableSecond.textColor = color;
  _lableSecond.font = font;
  _lableFirst.font = font;
  [self layoutSubviews];
  
}

- (void)setupChildViewFrame:(CGRect)frame Text:(NSString *)text andTitleFont:(UIFont *)font andTitleColor:(UIColor *)color{
  
  self.frame = frame;
  
  [_containerView.layer removeAnimationForKey:@"containerView animation"];
  
  font = font ? font : defaultFont;
  color = color ? color : defaultColor;
  
  self.titleFont = font;
  self.titleColor = color;
  
  UIView * containerView = [[UIView alloc]initWithFrame:self.bounds];
  containerView.backgroundColor = [UIColor clearColor];
  _containerView = containerView;
  [self addSubview:containerView];
  
  UILabel * labelFirst = [[UILabel alloc]init];
  labelFirst.textAlignment = NSTextAlignmentCenter;
  labelFirst.font = font;
  labelFirst.textColor = color;
  labelFirst.text = text;
  _lableFirst = labelFirst;
  [_containerView addSubview:labelFirst];
  
  UILabel * labelSecond = [[UILabel alloc]init];
  labelSecond.textAlignment = NSTextAlignmentCenter;
  labelSecond.font = font;
  labelSecond.text = text;
  labelSecond.textColor = color;
  _lableSecond = labelSecond;
  [_containerView addSubview:labelSecond];
  
}

- (void)beReadyToAnimateFrame:(CGRect)frame {
  
  CGRect rect = [self.lableFirst.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.lableFirst.font} context:nil];
  
  if (rect.size.width <= frame.size.width) {
    
    _lableFirst.frame = frame;
    _lableSecond.hidden = YES;
    [_containerView.layer removeAnimationForKey:@"containerView animation"];
    
  } else {
    
    _lableSecond.hidden = NO;
    _lableFirst.frame = CGRectMake(0, 0, rect.size.width, self.frame.size.height);
    _lableSecond.frame = CGRectMake(rect.size.width + labelMargin,0 , rect.size.width, self.frame.size.height);
    [self startToAnimate];
  }

}

- (void)startToAnimate{

  //move 20pt/s
  CGFloat speed = 20.0;
  CABasicAnimation * animate = [CABasicAnimation animation];
  animate.fromValue = @(0);
  animate.toValue=@( - self.lableFirst.frame.size.width - labelMargin);
  animate.keyPath = @"transform.translation.x";
  animate.duration = (_lableFirst.frame.size.width + labelMargin) / speed;
  animate.removedOnCompletion = YES;
  animate.repeatCount = MAXFLOAT;
  [_containerView.layer addAnimation:animate forKey:@"containerView animation"];
  
}
- (void)layoutSubviews{
  
  [super layoutSubviews];
  
  [self beReadyToAnimateFrame:self.bounds];
  
}


@end
