//
//  PastedTextView.m
//  Bootigo
//
//  Created by 배 철희 on 12. 4. 28..
//  Copyright (c) 2012년 me. All rights reserved.
//

#import "PastedTextView.h"

@implementation PastedTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchedEnded");
    UITouch *theTouch = [touches anyObject];
    
//    if ([theTouch tapCount] >= 1 && [self becomeFirstResponder]) {
    if ([theTouch tapCount] >= 1) {
        
//        UIMenuController *theMenu = [UIMenuController sharedMenuController];
        CGPoint point = [theTouch locationInView:self];
        NSLog(@"%f %f", point.x, point.y);
//        CGRect selectionRect = CGRectMake(point.x, point.y, 100, 100);
        //        [theMenu setTargetRect:selectionRect inView:self];
        //        [theMenu setMenuVisible:YES animated:YES];
    } else {
        NSLog(@"else");
    }
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    NSLog(@"test");
    UITextRange *range = self.selectedTextRange;
    NSLog(@"%@", range);
    [UIMenuController sharedMenuController].menuVisible = NO;
    if (action == @selector(select:)) {
        NSLog(@"select");
        return NO;
    }
    if (action == @selector(selectAll:)) {
        NSLog(@"selectAll");
        return NO;
    }
    
    return [super canPerformAction:action withSender:sender];
//    return NO;
}

-(BOOL)canBecomeFirstResponder {
    return NO;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"**touchesBegan");
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"**touchesMoved");
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"**touchesCancelled"); 
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
