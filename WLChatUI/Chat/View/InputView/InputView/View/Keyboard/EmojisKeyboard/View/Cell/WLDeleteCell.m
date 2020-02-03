//
//  WLDeleteCell.m
//  WLChat
//
//  Created by WangLei on 2018/9/5.
//  Copyright © 2018年 WangLei. All rights reserved.
//

#import "WLDeleteCell.h"
#import "WLInputHelper.h"

@implementation WLDeleteCell {
    UIImageView *_deleteImgView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _deleteImgView = [[UIImageView alloc] initWithFrame:CGRectMake(6, 5, 40, 40)];
        _deleteImgView.image = [WLInputHelper otherImageNamed:@"WL_chat_delete"];
        [self addSubview:_deleteImgView];
    }
    return self;
}

@end
