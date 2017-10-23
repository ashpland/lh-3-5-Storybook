//
//  ASHStoryPageViewController.m
//  Storybook
//
//  Created by Andrew on 2017-10-23.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import "ASHStoryPageViewController.h"
#import "ASHStoryPartViewController.h"
#import "ASHStoryPage.h"

@interface ASHStoryPageViewController ()
@property (strong, nonatomic) NSArray<ASHStoryPage *> *storyObjects;
@property (assign, nonatomic) NSInteger currentPage;
@property (assign, nonatomic) NSInteger lastPendingPage;

@end

@implementation ASHStoryPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.storyObjects = @[ [[ASHStoryPage alloc] initWithID:@"Story 0"] ,
                           [[ASHStoryPage alloc] initWithID:@"Story 1"] ,
                           [[ASHStoryPage alloc] initWithID:@"Story 2"] ,
                           [[ASHStoryPage alloc] initWithID:@"Story 3"] ,
                           [[ASHStoryPage alloc] initWithID:@"Story 4"]
                           ];
    
    self.currentPage = 0;
    self.lastPendingPage = 0;
    
    self.delegate = self;
    self.dataSource = self;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIPageControl* proxy = [UIPageControl appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    [proxy setPageIndicatorTintColor:[UIColor lightGrayColor]];
    [proxy setCurrentPageIndicatorTintColor:[UIColor blackColor]];
    [proxy setBackgroundColor:[UIColor whiteColor]];
    
    [self setViewControllers:@[[self getPageAtIndex:self.currentPage]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

- (ASHStoryPartViewController *)getPageAtIndex:(NSInteger)index{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ASHStoryPartViewController *newViewController = [storyboard instantiateViewControllerWithIdentifier:@"ASHStoryPartViewController"];
        
    newViewController.story = self.storyObjects[index];
    newViewController.index = index;
    
    return newViewController;
    
}

- (nullable UIViewController *)pageViewController:(nonnull UIPageViewController *)pageViewController viewControllerBeforeViewController:(nonnull UIViewController *)viewController {
   
    if (self.currentPage > 0){
        return [self getPageAtIndex:self.currentPage - 1];
    } else {
        return nil;
    }
}

- (nullable UIViewController *)pageViewController:(nonnull UIPageViewController *)pageViewController viewControllerAfterViewController:(nonnull UIViewController *)viewController {
    
    if (self.currentPage < (self.storyObjects.count - 1)){
        return [self getPageAtIndex:self.currentPage + 1];
    } else {
        return nil;
    }
}

-(void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
    if (pendingViewControllers.count > 0) {
        ASHStoryPartViewController *upcomingVC = (ASHStoryPartViewController *)pendingViewControllers[0];
        self.lastPendingPage = upcomingVC.index;
    }
}

-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed) {
        self.currentPage = self.lastPendingPage;
    }
}


-(NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return self.storyObjects.count;
}

-(NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return self.currentPage;
}

@end
