//
//  ASHStoryPage.h
//  Storybook
//
//  Created by Andrew on 2017-10-22.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface ASHStoryPage : NSObject

@property (nonatomic, copy) UIImage *image;
@property (nonatomic, copy) NSURL *audioRecordingURL;
@property (nonatomic, strong) NSString *objIDStr;
- (instancetype)initWithID:(NSString *)string;


@end
