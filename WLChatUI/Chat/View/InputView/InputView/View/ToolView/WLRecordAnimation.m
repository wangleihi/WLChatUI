//
//  WLRecordAnimation.m
//  WLChat
//
//  Created by WangLei on 2019/5/23.
//  Copyright © 2019 WangLei. All rights reserved.
//

#import "WLRecordAnimation.h"
#import "WLInputHelper.h"

@interface WLRecordAnimation ()

///录音时长
@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, assign, getter=isBegin) BOOL begin;

@end

@implementation WLRecordAnimation {
    NSArray *_images;
    CGFloat _nowTime;
}

- (instancetype)init {
    if (self = [super initWithFrame:CGRectMake(([WLInputHelper helper].screenW-120)/2, [WLInputHelper helper].screenH/2-120, 120, 120)]) {
        self.animationDuration    = 0.2;
        self.animationRepeatCount = 0;
        _images = @[[WLInputHelper otherImageNamed:@"WL_voice_1"],
                    [WLInputHelper otherImageNamed:@"WL_voice_2"],
                    [WLInputHelper otherImageNamed:@"WL_voice_3"],
                    [WLInputHelper otherImageNamed:@"WL_voice_4"],
                    [WLInputHelper otherImageNamed:@"WL_voice_5"],
                    [WLInputHelper otherImageNamed:@"WL_voice_6"]];
        self.begin = NO;
        self.volume = 0.0;
    }
    return self;
}

- (BOOL)beginRecord {
    if (self.isBegin) return NO;
    self.begin = YES;
    _nowTime = [self nowTimestamp];
    if (self.superview == nil) {
        [[UIApplication sharedApplication].delegate.window addSubview:self];
        [self showVoiceAnimation];
    }
    return YES;
}

- (BOOL)endRecord {
    if (self.isBegin == NO) return NO;
    self.begin = NO;
    self.duration = ([self nowTimestamp]-_nowTime);
    if (self.duration > 1000) {
        //录音完成
        if (self.superview) {
            [self removeFromSuperview];
        }
        return YES;
    }
    else {
        [self showVoiceShort];
        //录音时间太短
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.isBegin == NO) {
                if (self.superview) {
                    [self removeFromSuperview];
                }
            }
        });
        return NO;
    }
}

///录音取消
- (BOOL)cancelRecord {
    if (self.isBegin == NO) return NO;
    self.begin = NO;
    if (self.superview) {
        [self removeFromSuperview];
    }
    return YES;
}

//获取当前时间戳
- (NSTimeInterval)nowTimestamp {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time = [date timeIntervalSince1970]*1000;
    return time;
}

- (void)showVoiceCancel {
    [self stopAnimating];
    self.image = [WLInputHelper otherImageNamed:@"voice_cancel"];
}

- (void)showVoiceShort {
    [self stopAnimating];
    self.image = [WLInputHelper otherImageNamed:@"voice_short"];
}

- (void)showVoiceAnimation {
    if (_volume >= 0.8 ) {
        self.animationImages = @[_images[4],_images[5]];
    }
    else if (_volume >= 0.6 ) {
        self.animationImages = @[_images[3],_images[4]];
    }
    else if (_volume >= 0.4 ) {
        self.animationImages = @[_images[2],_images[3]];
    }
    else if (_volume >= 0.2) {
        self.animationImages = @[_images[1],_images[2]];
    }
    else {
        self.animationImages = @[_images[0],_images[1]];
    }
    [self startAnimating];
}

- (void)setVolume:(CGFloat)volume {
    if (_volume == volume) return;
    _volume = MIN(MAX(volume, 0.f),1.f);
    [self showVoiceAnimation];
}

- (void)removeFromSuperview {
    self.image = nil;
    [self stopAnimating];
    self.animationImages = nil;
    [super removeFromSuperview];
}

@end
