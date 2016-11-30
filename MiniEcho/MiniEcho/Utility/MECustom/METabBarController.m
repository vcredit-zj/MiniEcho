//
//  METabBarController.m
//  MiniEcho
//
//  Created by vcredit on 16/11/11.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "METabBarController.h"
#import "MEChannelViewController.h"
#import "MENavigationController.h"
#import "ViewController3.h"
#import "SearchHomeController.h"
@interface METabBarController ()

@end

@implementation METabBarController
- (instancetype)init {

    self = [super init];
    if (self) {
        NSArray *titleArray = @[@"动态",@"频道",@"回声",@"echoTV",@"名人"];
        NSArray *normalImageNameArray = @[@"icon_feed_normal",@"icon_channel_normal",@"icon_echo_normal",@"icon_live_default",@"icon_famous_normal"];
        NSArray *selectedImageNameArray = @[@"icon_feed_selected",@"icon_channel_selected",@"icon_echo_selected",@"icon_live_selected",@"icon_famous_selected"];
        NSArray *classArray = @[NSStringFromClass([SearchHomeController class]),
                                NSStringFromClass([MEChannelViewController class]),
                                NSStringFromClass([ViewController3 class]),
                                NSStringFromClass([UIViewController class]),
                                NSStringFromClass([UIViewController class])];
        self.viewControllers = [self tabBarViewControllers:classArray barTitles:titleArray barImageNormal:normalImageNameArray barImageSelected:selectedImageNameArray] ;
        
        self.selectedIndex = 0 ;
        UIImage *whiteImage = [MEUtil imageWithColor:[UIColor whiteColor]];
        self.tabBar.backgroundImage = whiteImage;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSDictionary *normalDic = @{NSForegroundColorAttributeName:[UIColor blackColor]};
    NSDictionary *selectedDic = @{NSForegroundColorAttributeName:[UIColor greenColor]};
    [[UITabBarItem appearance] setTitleTextAttributes:normalDic forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:selectedDic forState:UIControlStateSelected];
}
#pragma mark ----Helper -----
- (NSArray *)tabBarViewControllers:(NSArray *)classNameArr barTitles:(NSArray *)barTitleArr barImageNormal:(NSArray *)imageNormal barImageSelected:(NSArray *)imageSet
{
    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:classNameArr.count];
    for (int i = 0 ; i < classNameArr.count ; i++)
    {
        NSString *str = [classNameArr objectAtIndex:i];
        NSString *barTitle = [barTitleArr objectAtIndex:i];
        if (NSClassFromString(str)) {
            UIViewController *vc = [[NSClassFromString(str) alloc] init];
            vc.view.backgroundColor = [UIColor whiteColor];
            UIImage *normalImage = [UIImage imageNamed:imageNormal[i]] ;
            vc.tabBarItem.image = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
            UIImage *selectedImage = [UIImage imageNamed:imageSet[i]] ;
            vc.tabBarItem.selectedImage =[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
            vc.tabBarItem.title = barTitle;
            
            [vc.tabBarItem titleTextAttributesForState:UIControlStateNormal];
            
            MENavigationController *navi = [[MENavigationController alloc]initWithRootViewController:vc];
            [array addObject:navi];
        }
    }
    return array;
}
@end
