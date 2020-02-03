//
//  WLUserTableViewCell.m
//  WLChat
//
//  Created by WangLei on 2019/4/30.
//  Copyright © 2019 WangLei. All rights reserved.
//

#import "WLUserTableViewCell.h"
#import "UIView+WLChat.h"
#import "WZChatMacro.h"

@implementation WLUserTableViewCell {
    UIImageView *_avatarImageView;
    UILabel *_nameLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 40, 40)];
        _avatarImageView.chat_cornerRadius = 5;
        [self addSubview:_avatarImageView];
        
        CGFloat nickX = _avatarImageView.chat_maxX+15;
        CGFloat nickW = CHAT_SCREEN_WIDTH-nickX-20;
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nickX, 0, nickW, 60)];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textColor = [UIColor darkTextColor];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_nameLabel];
    }
    return self;
}

- (void)setConfig:(WLChatUserModel *)model {
    [WLChatHelper getImageWithUrl:model.avatar placeholder:CHAT_BAD_IMAGE completion:^(UIImage *image) {
        _avatarImageView.image = image;
    }];
    _nameLabel.text = model.name;
}

@end
