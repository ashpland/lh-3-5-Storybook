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
@property (strong, nonatomic) NSArray *storyObjects;
@property (assign, nonatomic) NSInteger currentPage;

@end

@implementation ASHStoryPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.storyObjects = @[ [ASHStoryPage new],
                           [ASHStoryPage new],
                           [ASHStoryPage new],
                           [ASHStoryPage new],
                           [ASHStoryPage new] ];
    
    self.currentPage = 0;
    
    self.dataSource = self;
    
    [self setViewControllers:@[[self getPageAtIndex:self.currentPage]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

- (ASHStoryPartViewController *)getPageAtIndex:(NSInteger)index{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ASHStoryPartViewController *newViewController = [storyboard instantiateViewControllerWithIdentifier:@"ASHStoryPartViewController"];
    
    newViewController.story = self.storyObjects[index];
    
    return newViewController;
    
}

- (nullable UIViewController *)pageViewController:(nonnull UIPageViewController *)pageViewController viewControllerBeforeViewController:(nonnull UIViewController *)viewController {
    
    if (self.currentPage > 0){
        self.currentPage = self.currentPage - 1;
        return [self getPageAtIndex:self.currentPage];
    } else {
        return nil;
    }
}

- (nullable UIViewController *)pageViewController:(nonnull UIPageViewController *)pageViewController viewControllerAfterViewController:(nonnull UIViewController *)viewController {
    if (self.currentPage < (self.storyObjects.count - 2)){
        self.currentPage = self.currentPage + 1;
        return [self getPageAtIndex:self.currentPage];
    } else {
        return nil;
    }
}


-(NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return self.storyObjects.count;
}

-(NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return self.currentPage;
}

@end
