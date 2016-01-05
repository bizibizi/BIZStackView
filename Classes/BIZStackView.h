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
- (NSInteger)numberOfItemsInStackView:(BIZStackView *)stackView;
- (UIView *)stackView:(BIZStackView *)stackView itemForRowAtIndex:(NSInteger)index;
- (CGFloat)stackView:(BIZStackView *)stackView heightForRowAtIndex:(NSInteger)index;
@end


@protocol BIZStackViewDelegate <NSObject>
@optional
- (BOOL)stackView:(BIZStackView *)stackView didSelectItemAtIndex:(NSInteger)index;
@end


@interface BIZStackView : UIScrollView
@property(nonatomic) id <BIZStackViewDataSource> dataSource;
@property(nonatomic) id <BIZStackViewDelegate> stackViewDelegate;

- (void)reloadData;
- (void)restoreStateAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
- (void)showFullScreenItemByView:(UIView *)view completion:(void (^)(BOOL finished))completion;
- (void)showFullScreenItemAtIndex:(NSInteger)index completion:(void (^)(BOOL finished))completion;
- (void)restoreItemAtIndex:(NSInteger)index completion:(void (^)(BOOL finished))completion;

@end
