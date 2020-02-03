//
//  WLChatVideoMessageCell.m
//  WLChat
//
//  Created by WangLei on 2019/5/22.
//  Copyright © 2019 WangLei. All rights reserved.
//

#import "WLChatVideoMessageCell.h"
#import "WLChatHelper.h"
#import "WZChatMacro.h"

@implementation WLChatVideoMessageCell {
    UIImageView *_markImageView;
    UIImageView *_contentImageView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _contentImageView = [[UIImageView alloc] init];
        _contentImageView.layer.masksToBounds = YES;
        _contentImageView.layer.cornerRadius = 5;
        [self addSubview:_contentImageView];
        
        _markImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        _markImageView.image = [WLInputHelper otherImageNamed:@"WL_chat_video_mark"];
        [self addSubview:_markImageView];
    }
    return self;
}

- (void)setConfig:(WLChatMessageModel *)model isShowName:(BOOL)isShowName {
    [super setConfig:model isShowName:isShowName];
    
    _contentImageView.frame = _contentRect;
    _markImageView.center = _contentImageView.center;
    
    [WLChatHelper getImageWithUrl:model.coverUrl placeholder:CHAT_BAD_IMAGE completion:^(UIImage *image) {
        _contentImageView.image = image;
    }];
}

@end
