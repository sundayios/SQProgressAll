//
//  ZWAssistanceInviteProgressView.h
//  Ymd
//
//  Created by 云免 on 2019/1/5.
//  Copyright © 2019年 云免. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQProgressView : UIView

- (void)progressCurrentCount:(NSInteger)currentCount endCount:(NSInteger)endCount showAnimation:(BOOL)showAnimation;
@end

NS_ASSUME_NONNULL_END
