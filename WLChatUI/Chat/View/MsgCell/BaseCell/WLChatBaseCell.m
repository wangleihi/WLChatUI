//
//  WLChatBaseCell.m
//  WLChat
//
//  Created by WangLei on 2019/1/15.
//  Copyright © 2019 WangLei. All rights reserved.
//

#import "WLChatBaseCell.h"

@implementation WLChatBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setConfig:(WLChatMessageModel *)model {}
- (void)setConfig:(WLChatMessageModel *)model isShowName:(BOOL)isShowName {}

@end
