//
//  PastedScrollView.m
//  Pasty
//
//  Created by 배 철희 on 12. 3. 26..
//  Copyright (c) 2012년 . All rights reserved.
//

#import "PastedScrollView.h"
#import "ViewController.h"
#import "WordLabel.h"

@implementation PastedScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// 스크롤하기 위해 드래그 시 터치한 곳이 버튼인 경우 버튼 터치가 먼저 먹는 현상 방지
- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    if ([view isKindOfClass:[WordLabel class]]) {
        return YES;
    } else {
        return NO;
    }
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan");
    ViewController *controller = (ViewController *)self.delegate;
    [controller touchesEndedOutside:touches withEvent:event];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
