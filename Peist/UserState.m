//
//  UserState.m
//  Pasty
//
//  Created by 배 철희 on 12. 3. 31..
//  Copyright (c) 2012년 . All rights reserved.
//

#import "UserState.h"

@implementation UserState

@synthesize dictTitle = _dictTitle, dictUrl = _dictUrl, dictIndex = _dictIndex;
@synthesize onthego = _onthego;
@synthesize fontName = _fontName, fontSize = _fontSize;
@synthesize pasteLock = _pasteLock;

-(id)initWithDictTitle:(NSString *)title url:(NSString *)url index: (NSInteger) index onthego:(BOOL) onthego pasteLock:(BOOL)pasteLock {
    self = [super init];
    if (self) {
        _dictTitle = title;
        _dictUrl = url;
        _dictIndex = index;
        _onthego = onthego;
        _fontName = @"Palatino";
        _fontSize = 21;
        _pasteLock = pasteLock;

        return self;
    }
    
    return nil;
}
@end
