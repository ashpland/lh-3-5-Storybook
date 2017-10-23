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
@property (assign, nonatomic) NSInteger currentIndex;
@property (assign, nonatomic) NSInteger upcomingIndex;
@property (strong, nonatomic) UIPageControl *pageControl;

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
    
    self.delegate = self;
    self.dataSource = self;
    self.currentIndex = 0;
    
    

    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIPageControl* proxy = [UIPageControl appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    [proxy setPageIndicatorTintColor:[UIColor lightGrayColor]];
    [proxy setCurrentPageIndicatorTintColor:[UIColor blackColor]];
    [proxy setBackgroundColor:[UIColor whiteColor]];
    
    [self setViewControllers:@[[self getPageAtIndex:0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    self.pageControl = [[self.view.subviews filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(class = %@)", [UIPageControl class]]] lastObject];
    [self.pageControl addTarget:self action:@selector(changePageFromControl:) forControlEvents:UIControlEventTouchUpInside];

    
}

- (ASHStoryPartViewController *)getPageAtIndex:(NSInteger)index{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ASHStoryPartViewController *newViewController = [storyboard instantiateViewControllerWithIdentifier:@"ASHStoryPartViewController"];
        
    newViewController.story = self.storyObjects[index];
    newViewController.index = index;
    
    return newViewController;
    
}

- (nullable UIViewController *)pageViewController:(nonnull UIPageViewController *)pageViewController viewControllerBeforeViewController:(nonnull UIViewController *)viewController {
   
    ASHStoryPartViewController *currentVC = (ASHStoryPartViewController *)viewController;
    
    if (currentVC.index > 0){
        return [self getPageAtIndex:currentVC.index - 1];
    } else {
        return nil;
    }
}

- (nullable UIViewController *)pageViewController:(nonnull UIPageViewController *)pageViewController viewControllerAfterViewController:(nonnull UIViewController *)viewController {
    
    ASHStoryPartViewController *currentVC = (ASHStoryPartViewController *)viewController;

    if (currentVC.index < (self.storyObjects.count - 1)){
        return [self getPageAtIndex:currentVC.index + 1];
    } else {
        return nil;
    }
}


- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
    if (pendingViewControllers.count > 0) {
        ASHStoryPartViewController *pendingView = (ASHStoryPartViewController *)pendingViewControllers[0];
        self.upcomingIndex = pendingView.index;
    }
}

-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed) {
        self.currentIndex = self.upcomingIndex;
    }
}

-(NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return self.storyObjects.count;
}

-(NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    
    return self.currentIndex;
}

-(void)changePageFromControl:(UIPageControl *)sender {
    [self setViewControllers:@[[self getPageAtIndex:sender.currentPage]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}




@end
