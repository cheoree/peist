//
//  UserState.h
//  Pasty
//
//  Created by 배 철희 on 12. 3. 31..
//  Copyright (c) 2012년 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserState : NSObject

@property (nonatomic, copy) NSString *dictTitle;
@property (nonatomic, copy) NSString *dictUrl;
@property (nonatomic) NSInteger dictIndex;
@property (nonatomic) BOOL onthego;
@property (nonatomic, copy) NSString *fontName;
@property (nonatomic) NSInteger fontSize;
@property (nonatomic) BOOL pasteLock;

-(id)initWithDictTitle:(NSString *)dictTitle url:(NSString *)dictUrl index: (NSInteger) dictIndex onthego :(BOOL)onthego pasteLock:(BOOL)pasteLock;

@end
