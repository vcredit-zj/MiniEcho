//
//  MEChannelCollectionReusableHeaderView.m
//  MiniEcho
//
//  Created by vcredit on 16/11/15.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "MEChannelCollectionReusableHeaderView.h"


@implementation HeaderModel

@end
@interface MEChannelCollectionReusableHeaderView ()
@property (nonatomic,strong)UIImageView *leftImageView;
@end
@implementation MEChannelCollectionReusableHeaderView
+ (UINib *)nib
{
    NSString *className = NSStringFromClass(self) ;
    return [UINib nibWithNibName:className bundle:nil] ;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

@end
