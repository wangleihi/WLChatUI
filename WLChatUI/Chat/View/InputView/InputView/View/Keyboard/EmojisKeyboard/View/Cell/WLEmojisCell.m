//
//  WLEmojisCell.m
//  WLChat
//
//  Created by WangLei on 2018/9/5.
//  Copyright © 2018年 WangLei. All rights reserved.
//

#import "WLEmojisCell.h"

@implementation WLEmojisCell {
    UILabel *_emojisLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _emojisLabel = [[UILabel alloc] initWithFrame:CGRectMake(4, 0, 45, 45)];
        _emojisLabel.font = [UIFont systemFontOfSize:33];
        _emojisLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_emojisLabel];
    }
    return self;
}

- (void)setConfig:(NSString *)emojis {
    _emojisLabel.text = emojis;
}

@end
