# BIZStackView

Wait for gif presentation, it's loading...

![alt tag](https://github.com/bizibizi/BIZSlackView/blob/master/presentation.gif)


BIZStackView is a subclass of UIScrollView that presents scrolling stack of cards.

# Usage

```objective-c
//add motion
[self.imageView addMotionToDirection:kMotionDirectionUp];
//remove motion
[self.imageView removeMotion];
```

# Installation

 - Copy BIZStackView folder to your project 
 - ```#import "BIZStackView.h"``` 
 - Create ```BIZStackView``` like UIScrollView with code or with Storyboard (set class )
 - implement ```BIZStackViewDataSource```
```objective-c
@interface ViewController () <BIZStackViewDataSource>
...
- (void)viewDidLoad
{
...
self.stackView.dataSource = self;
}

- (NSInteger)numberOfItemsInStackView:(BIZStackView *)stackView
{
...
}

- (UIView *)stackView:(BIZStackView *)stackView itemForRowAtIndex:(NSInteger)index
{
...
}

- (CGFloat)stackView:(BIZStackView *)stackView heightForRowAtIndex:(NSInteger)index
{
...
}
 
```
