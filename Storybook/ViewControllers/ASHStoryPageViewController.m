//
//  ASHStoryPageViewController.m
//  Storybook
//
//  Created by Andrew on 2017-10-22.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import "ASHStoryPageViewController.h"
#import "ASHStoryPage.h"

@interface ASHStoryPageViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *storyImageView;
- (IBAction)storyMicrophoneButton:(UIButton *)sender;
- (IBAction)storyCameraButton:(UIButton *)sender;
- (IBAction)storyImageTapped:(UITapGestureRecognizer *)sender;
@property (weak, nonatomic) IBOutlet UIButton *microphoneButtonLabel;

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) AVAudioRecorder *audioRecorder;
@property (strong, nonatomic) NSTimer *recordingAnimationTimer;


@end

@implementation ASHStoryPageViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
    
    
}

- (void)setupUI {
    CALayer *layer = self.microphoneButtonLabel.layer;
    layer.shadowOffset = CGSizeMake(0, 0);
    layer.shadowColor = [[UIColor redColor] CGColor];
    layer.shadowRadius = 4.0f;
    layer.shadowOpacity = 0.0f;
}

- (AVAudioRecorder *)recorderSetup {
    NSArray *filePath = @[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject], @"audio.m4a" ];

    NSURL *fileURL = [NSURL fileURLWithPathComponents:filePath];
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];

    NSMutableDictionary<NSString *, NSNumber *> *recordSettings = @{
                                            AVFormatIDKey : [NSNumber numberWithInteger:kAudioFormatMPEG4AAC],
                                            AVSampleRateKey : @44100.0,
                                            AVNumberOfChannelsKey : @2
                                            }.mutableCopy;
    AVAudioRecorder *newAudioRecorder = [[AVAudioRecorder alloc] initWithURL:fileURL
                                                     settings:recordSettings
                                                        error:nil];
    
    newAudioRecorder.delegate = self;
    newAudioRecorder.meteringEnabled = YES;
    
    
    
    return newAudioRecorder;
}



-(AVAudioRecorder *)audioRecorder {
    if (!_audioRecorder)
        _audioRecorder = [self recorderSetup];
    return _audioRecorder;
}


- (IBAction)storyMicrophoneButton:(UIButton *)sender {
    if (_audioPlayer && self.audioPlayer.playing)
        [self.audioPlayer stop];

    if (!self.audioRecorder.recording) {
        [[AVAudioSession sharedInstance] setActive:YES error:nil];

        [self.audioRecorder record];
        
        [self animateMicrophone];
        self.recordingAnimationTimer = [NSTimer scheduledTimerWithTimeInterval:1.5
                                                                        target:self
                                                                      selector:@selector(animateMicrophone)
                                                                      userInfo:nil
                                                                       repeats:YES];
    } else {
        [self.audioRecorder stop];
        [self.recordingAnimationTimer invalidate];
        [self.microphoneButtonLabel.layer removeAllAnimations];
    }
}

-(void)animateMicrophone {
    [CATransaction begin];
    
    // Fade in
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
    anim.fromValue = [NSNumber numberWithFloat:0.0];
    anim.toValue = [NSNumber numberWithFloat:1.0];
    anim.duration = 1;
    
    [CATransaction setCompletionBlock:^{
        // Fade out
        CABasicAnimation *anim2 = [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
        anim2.fromValue = [NSNumber numberWithFloat:1.0];
        anim2.toValue = [NSNumber numberWithFloat:0.0];
        anim2.duration = 0.5;
        [self.microphoneButtonLabel.layer addAnimation:anim2 forKey:@"shadowOpacity"];
        self.microphoneButtonLabel.layer.shadowOpacity = 0.0;
    }];

    [self.microphoneButtonLabel.layer addAnimation:anim forKey:@"shadowOpacity"];
    self.microphoneButtonLabel.layer.shadowOpacity = 1.0;

    [CATransaction commit];
}

- (IBAction)storyCameraButton:(UIButton *)sender {
    
}

- (IBAction)storyImageTapped:(UITapGestureRecognizer *)sender {
    if (_audioRecorder && !self.audioRecorder.recording){
        if (_audioPlayer && self.audioPlayer.playing) {
            [self.audioPlayer stop];
        } else {
            self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.audioRecorder.url error:nil];
            [self.audioPlayer setDelegate:self];
            [self.audioPlayer play];
        }
    }
}
@end
