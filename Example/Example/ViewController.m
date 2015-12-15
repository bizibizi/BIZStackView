//
//  ViewController.m
//  Example
//
//  Created by IgorBizi@mail.ru on 12/15/15.
//  Copyright © 2015 IgorBizi@mail.ru. All rights reserved.
//

#import "ViewController.h"
#import "BIZStackView.h"
@import QuartzCore;
#import "DetailViewController.h"


@interface ViewController () <BIZStackViewDataSource, BIZStackViewDelegate>
@property (weak, nonatomic) IBOutlet BIZStackView *stackView;
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
    
    self.stackView.stackViewDelegate = self;
    self.stackView.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.stackView restoreStateAnimated:YES completion:nil];
}


#pragma mark - BIZStackViewDataSource


- (NSInteger)numberOfItemsInStackView:(BIZStackView *)stackView
{
    return self.dataSource.count;
}

- (UIView *)stackView:(BIZStackView *)stackView itemForRowAtIndex:(NSInteger)index
{
    CGFloat w = self.view.bounds.size.width - 60;
    CGFloat h = 400;
    UIImageView *view = [[UIImageView alloc] initWithImage:self.dataSource[index]];
    view.frame = CGRectMake(0, 0, w, h);
    view.layer.cornerRadius = 30;
    view.layer.masksToBounds = YES;
    
    return view;
}

- (CGFloat)stackView:(BIZStackView *)stackView heightForRowAtIndex:(NSInteger)index
{
    return 120;
}


#pragma mark - BIZStackViewDelegate


- (BOOL)stackView:(BIZStackView *)stackView didSelectItemAtIndex:(NSInteger)index
{
    [stackView showFullScreenItemAtIndex:index completion:^(BOOL finished) {
        UIImage *image = ((UIImageView *)[self stackView:stackView itemForRowAtIndex:index]).image;
        [self performSegueWithIdentifier:@"show details"
                                  sender:image];
    }];
    return NO;
}


#pragma mark - UIViewController


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[DetailViewController class]]) {
        if ([segue.identifier isEqualToString:@"show details"]) {
            ((DetailViewController *)segue.destinationViewController).image = sender;
        }
    }
}


@end
