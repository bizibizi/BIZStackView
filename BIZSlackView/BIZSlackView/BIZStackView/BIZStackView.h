//
//  BIZStackView.h
//  CultTourist
//
//  Created by IgorBizi@mail.ru on 15.05.14.
//  Copyright (c) 2014 IgorBizi@mail.ru. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BIZStackView;


@protocol BIZStackViewDataSource <NSObject>
@required
- (NSInteger)numberOfItemsInStackedMenu:(BIZStackView *)stackedMenu;
- (UIView *)stackedMenu:(BIZStackView *)stackedMenu itemForRowAtIndex:(NSInteger)index;
- (CGFloat)heightForRowAtIndex:(NSInteger)index;
@end


@protocol BIZStackViewDelegate <NSObject>
@optional
- (BOOL)stackedMenu:(BIZStackView *)stackedMenu didSelectRowAtIndex:(NSInteger)index;
@end


@interface BIZStackView : UIScrollView
@property(nonatomic) id <BIZStackViewDataSource> dataSource;
@property(nonatomic) id <BIZStackViewDelegate> stackedMenuDelegate;

- (void)reloadData;
- (void)restoreStateAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
- (void)showFullScreenItemByView:(UIView *)view completion:(void (^)(BOOL finished))completion;
- (void)showFullScreenItemAtIndex:(NSInteger)index completion:(void (^)(BOOL finished))completion;
- (void)restoreItemAtIndex:(NSInteger)index completion:(void (^)(BOOL finished))completion;

@end
