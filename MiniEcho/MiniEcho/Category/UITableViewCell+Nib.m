//
//  UITableViewCell+Nib.m
//  StarCredit
//
//  Created by 胡阳 on 16/3/21.
//  Copyright © 2016年 VCredit. All rights reserved.
//

#import "UITableViewCell+Nib.h"

@implementation UITableViewCell (Nib)


+ (UINib*)nib
{
    return  [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

@end
