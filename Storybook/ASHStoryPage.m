//
//  ASHStoryPage.m
//  Storybook
//
//  Created by Andrew on 2017-10-22.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import "ASHStoryPage.h"

@implementation ASHStoryPage

- (instancetype)initWithID:(NSString *)string
{
    self = [super init];
    if (self) {
        _objIDStr = string;
    }
    return self;
}

@end
