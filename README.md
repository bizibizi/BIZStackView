# BIZStackView

*Wait for gif presentation, it's loading...*

![alt tag](https://github.com/bizibizi/BIZSlackView/blob/master/presentation.gif)


BIZStackView is a subclass of UIScrollView that presents scrolling stack of cards.

# Installation

 - Copy BIZStackView folder to your project 
 - ```#import "BIZStackView.h"``` 

# Usage

 - Create UIScrollView via code or Storyboard and place wherever you desire. 
 - Set UIScrollView's class to```BIZStackView```.
 - Implement ```BIZStackViewDataSource``` and setup ```BIZStackView```
```objective-c
@interface ViewController () <BIZStackViewDataSource>
@property (weak, nonatomic) IBOutlet BIZStackView *stackView;
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
- Implement ```BIZStackViewDelegate```if you need to handle ```BIZStackView``` actions
```objective-c
@interface ViewController () <BIZStackViewDataSource, BIZStackViewDelegate>
...

- (BOOL)stackView:(BIZStackView *)stackView didSelectItemAtIndex:(NSInteger)index
{
...
}
```
 
