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

 
# License
 
 The MIT License (MIT)

Copyright (c) 2015 Igor Bizi

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
