//
//  ZWAssistanceInviteProgressView.m
//  Ymd
//
//  Created by 云免 on 2019/1/5.
//  Copyright © 2019年 云免. All rights reserved.
//

#import "SQProgressView.h"

@interface SQProgressView ()
{
    UIImageView             *pathwayView;
    UIImageView             *progressView;
    
    UIImageView             *currentPoint;
    UIImageView             *aircraftView;
    UIImageView             *currentValueView;
    
    UIImageView             *endPoint;
    
    UILabel                 *currentCountLabel;
    UILabel                 *endCountLabel;
}
@property (nonatomic, assign) float currentCount;
@property (nonatomic, assign) float endCount;
@property (nonatomic, assign) BOOL showAnimation;
@end

@implementation SQProgressView


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initUI];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self initUI];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    self.currentCount = 5;
    self.endCount = 5;

    pathwayView = [[UIImageView alloc] init];
    pathwayView.image = [UIImage imageNamed:@"assistance_way"];
    [self addSubview:pathwayView];
    
    progressView = [[UIImageView alloc] init];
    progressView.image = [UIImage imageNamed:@"assistance_progress"];
    [pathwayView addSubview:progressView];
    
    currentPoint = [[UIImageView alloc] init];
    currentPoint.image = [UIImage imageNamed:@"assistance_current_point"];
    [progressView addSubview:currentPoint];
    
    aircraftView = [[UIImageView alloc] init];
    aircraftView.image = [UIImage imageNamed:@"assistance_plane"];
    [pathwayView addSubview:aircraftView];
    
    currentValueView = [[UIImageView alloc] init];
    currentValueView.image = [UIImage imageNamed:@"assistance_tag_yellow"];
    [pathwayView addSubview:currentValueView];
    
    endPoint = [[UIImageView alloc] init];
    endPoint.image = [UIImage imageNamed:@"assistance_red_flag"];
    [pathwayView addSubview:endPoint];
    
    currentCountLabel = [[UILabel alloc] init];
    currentCountLabel.textColor = ColorHexB46C06;
    currentCountLabel.font = PingFangSCRegular12;
    currentCountLabel.textAlignment = NSTextAlignmentCenter;
    [currentValueView addSubview:currentCountLabel];
    
    endCountLabel = [[UILabel alloc] init];
    endCountLabel.textColor = WhiteColor;
    endCountLabel.font = PingFangSCRegular12;
    endCountLabel.textAlignment = NSTextAlignmentCenter;
    [endPoint addSubview:endCountLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    pathwayView.frame = CGRectMake(0, 35, self.width, 14);
    
//    [currentValueView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self->currentPoint).offset(1);
//        make.top.equalTo(self->pathwayView.mas_top).offset(-28);
//        make.width.offset(40);
//        make.height.offset(23);
//    }];
    
//    [currentCountLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self->currentValueView);
//        make.centerY.equalTo(self->currentValueView).offset(-2);
//        make.width.equalTo(self->currentValueView);
//        make.height.offset(10);
//    }];
    
    [endPoint mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self->pathwayView.mas_bottom).offset(-3.5);
        make.right.equalTo(self->pathwayView.mas_right).offset(30);
        make.width.offset(48);
        make.height.offset(45);
    }];
    
    [endCountLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(7);
        make.left.offset(10);
        make.right.offset(-1);
        make.height.offset(10);
    }];
    
    if (self.showAnimation) {
        progressView.frame = CGRectMake(0, 0, 0, pathwayView.height);
        currentPoint.frame = CGRectMake(CGRectGetMaxX(progressView.frame) - 16, -1, 16, 16);
        aircraftView.frame = CGRectMake(0, 0, 15, 15);
        currentValueView.frame = CGRectMake(CGRectGetMaxX(progressView.frame) - 26, -28, 40, 23);
        currentCountLabel.frame = CGRectMake(0, 5, currentValueView.width, 10);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            [UIView animateWithDuration:1.5 animations:^{
                CGRect rect = progressView.frame;
                rect.size.width =  (self.currentCount /  self.endCount) * pathwayView.width;
                progressView.frame = rect;
                
                CGRect rect1 = currentPoint.frame;
                rect1.origin.x = CGRectGetMaxX(progressView.frame) - 16;
                currentPoint.frame = rect1;
                
                CGRect rect2 = aircraftView.frame;
                rect2.origin.x = CGRectGetMaxX(progressView.frame);
                aircraftView.frame = rect2;
                
                CGRect rect3 = currentValueView.frame;
                rect3.origin.x = CGRectGetMaxX(progressView.frame) - 26;
                currentValueView.frame = rect3;
            }];

            if (self.endCount - self.currentCount <= 10) {
                [UIView animateWithDuration:2.0 animations:^{
                    aircraftView.alpha = 0.0;
                }];
            }
            if (self.currentCount >= self.endCount) {
                [UIView animateWithDuration:2.0 animations:^{
                    aircraftView.alpha = 0;
                    currentPoint.alpha = 0;
                    currentValueView.alpha = 0;
                }];
            }
        });
    }else {
        progressView.frame = CGRectMake(0, 0, (self.currentCount /  self.endCount) * pathwayView.width, pathwayView.height);
        currentPoint.frame = CGRectMake(CGRectGetMaxX(progressView.frame) - 16, -1, 16, 16);
        aircraftView.frame = CGRectMake(CGRectGetMaxX(progressView.frame), 0, 15, 15);
        currentValueView.frame = CGRectMake(CGRectGetMaxX(progressView.frame) - 26, -28, 40, 23);
        currentCountLabel.frame = CGRectMake(0, 5, currentValueView.width, 10);
        
        if (self.endCount - self.currentCount <= 10) {
            aircraftView.alpha = 0.0;
        }
        if (self.currentCount >= self.endCount) {
            aircraftView.alpha = 0;
            currentPoint.alpha = 0;
            currentValueView.alpha = 0;
        }
    }
}

- (void)progressCurrentCount:(NSInteger)currentCount endCount:(NSInteger)endCount showAnimation:(BOOL)showAnimation{
    
    aircraftView.alpha = 1;
    aircraftView.alpha = 1;
    currentPoint.alpha = 1;
    currentValueView.alpha = 1;
    
    currentCountLabel.text = [NSString stringWithFormat:@"%ld%%",currentCount];
    endCountLabel.text = [NSString stringWithFormat:@"%ld%%",endCount];
    
    NSInteger startCount = 5;
    if (currentCount < startCount) {
        currentCount = startCount;
    }
    
    self.currentCount = (float)currentCount;
    self.endCount = (float)endCount;
    self.showAnimation = showAnimation;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
@end
