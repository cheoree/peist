//
//  WordLabel.h
//  Bootigo
//
//  Created by 배 철희 on 12. 4. 29..
//  Copyright (c) 2012년 me. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WordLabelDelegate;
@interface WordLabel : UILabel {
    bool isTapped;
    bool isFirst;
    id delegate;
}
@property (nonatomic) bool isTapped;
@property (weak, nonatomic) id <WordLabelDelegate> delegate;
@property (nonatomic, strong) NSString *fontName;
@property (nonatomic) NSInteger fontSize;
@property (nonatomic, strong) UILabel *textLabel;

- (id)initWithFrame:(CGRect)frame title:(NSString *)title;
- (id)initWithFrame:(CGRect)frame title:(NSString *)title fontName:(NSString *)fontName fontSize:(CGFloat)fontSize;
- (void)changeSelectedState:(BOOL)selected;
- (void)longPressed;
- (void)tapped;
@end

@protocol WordLabelDelegate <NSObject>
- (void)wordTouched:(WordLabel *)wordButton;
- (void)wordLongPressed:(WordLabel *)wordButton;
@end
