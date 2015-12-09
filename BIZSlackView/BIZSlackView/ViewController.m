//
//  ViewController.m
//  BIZSlackView
//
//  Created by IgorBizi@mail.ru on 12/9/15.
//  Copyright © 2015 IgorBizi@mail.ru. All rights reserved.
//

#import "ViewController.h"
#import "BIZStackView.h"
@import QuartzCore;
#import "DetailViewController.h"


@interface ViewController () <BIZStackViewDataSource, BIZStackViewDelegate>
@property (weak, nonatomic) IBOutlet BIZStackView *stackedMenu;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataSource = [NSMutableArray array];
    for (NSInteger i = 1; i <= 11; i++)
    {
        [self.dataSource addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg", (long)i]]];
    }

    self.stackedMenu.stackedMenuDelegate = self;
    self.stackedMenu.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.stackedMenu restoreStateAnimated:YES completion:nil];
}

- (NSInteger)numberOfItemsInStackedMenu:(BIZStackView *)stackedMenu
{
    return self.dataSource.count;
}

- (UIView *)stackedMenu:(BIZStackView *)stackedMenu itemForRowAtIndex:(NSInteger)index
{
    CGFloat w = self.view.bounds.size.width - 60;
    CGFloat h = 400;
    UIImageView *view = [[UIImageView alloc] initWithImage:self.dataSource[index]];
    view.frame = CGRectMake(0, 0, w, h);
    view.layer.cornerRadius = 30;
    view.layer.masksToBounds = YES;
    
    return view;
}

- (CGFloat)heightForRowAtIndex:(NSInteger)index
{
    return 120;
}

- (BOOL)stackedMenu:(BIZStackView *)stackedMenu didSelectRowAtIndex:(NSInteger)index
{
    [stackedMenu showFullScreenItemAtIndex:index completion:^(BOOL finished) {
        UIImage *image = ((UIImageView *)[self stackedMenu:stackedMenu itemForRowAtIndex:index]).image;
        [self performSegueWithIdentifier:@"show details"
                                  sender:image];
    }];
    return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[DetailViewController class]]) {
        if ([segue.identifier isEqualToString:@"show details"]) {
            ((DetailViewController *)segue.destinationViewController).image = sender;
        }
    }
}


@end
