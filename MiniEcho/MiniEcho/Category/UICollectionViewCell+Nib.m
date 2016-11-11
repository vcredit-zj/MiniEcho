//
//  UICollectionViewCell+Nib.m
//  HYEcho
//
//  Created by AiDong on 15/11/9.
//  Copyright © 2015年 AiDong. All rights reserved.
//

#import "UICollectionViewCell+Nib.h"

@implementation UICollectionViewCell (Nib)

+ (UINib *)nib
{
    NSString *className = NSStringFromClass(self) ;
    return [UINib nibWithNibName:className bundle:nil] ;
}



@end
