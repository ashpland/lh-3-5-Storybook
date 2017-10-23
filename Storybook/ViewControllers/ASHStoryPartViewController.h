//
//  ASHStoryPartViewController.h
//  Storybook
//
//  Created by Andrew on 2017-10-22.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import "ASHStoryPage.h"
#import <UIKit/UIKit.h>
@import AVFoundation;

@interface ASHStoryPartViewController : UIViewController <AVAudioRecorderDelegate, AVAudioPlayerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (strong, nonatomic) ASHStoryPage *story;

@end
