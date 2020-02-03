//
//  WLEmoticonCell.m
//  WLChat
//
//  Created by WangLei on 2019/5/16.
//  Copyright © 2019 WangLei. All rights reserved.
//

#import "WLEmoticonCell.h"
#import "WLInputHelper.h"

@implementation WLEmoticonCell {
    UIImageView *_emoticonImageView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _emoticonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(9, 6, 35, 35)];
        [self addSubview:_emoticonImageView];
    }
    return self;
}

- (void)setConfig:(NSString *)image {
    _emoticonImageView.image = [WLInputHelper emoticonImageNamed:image];
}

@end
