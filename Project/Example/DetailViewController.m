//
//  DetailViewController.m
//  BIZSlackView
//
//  Created by IgorBizi@mail.ru on 12/9/15.
//  Copyright © 2015 IgorBizi@mail.ru. All rights reserved.
//

#import "DetailViewController.h"


@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end


@implementation DetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.imageView.image = self.image;
    self.imageView.userInteractionEnabled = YES;
    self.imageView.layer.cornerRadius = 30;
    self.imageView.layer.masksToBounds = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self.imageView addGestureRecognizer:tap];
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:NO completion:nil];
}



@end
