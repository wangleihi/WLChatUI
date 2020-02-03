//
//  WLChatImageMessageCell.m
//  WLChat
//
//  Created by WangLei on 2018/9/4.
//  Copyright © 2018年 WangLei. All rights reserved.
//

#import "WLChatImageMessageCell.h"
#import "WLChatHelper.h"
#import "WZChatMacro.h"

@implementation WLChatImageMessageCell {
    UIImageView *_contentImageView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _contentImageView = [[UIImageView alloc] init];
        _contentImageView.layer.masksToBounds = YES;
        _contentImageView.layer.cornerRadius = 5;
        [self addSubview:_contentImageView];
    }
    return self;
}

- (void)setConfig:(WLChatMessageModel *)model isShowName:(BOOL)isShowName {
    [super setConfig:model isShowName:isShowName];
    
    _contentImageView.frame = _contentRect;
    
    [WLChatHelper getImageWithUrl:model.thumbnail placeholder:CHAT_BAD_IMAGE completion:^(UIImage *image) {
        _contentImageView.image = image;
    }];
}

@end
