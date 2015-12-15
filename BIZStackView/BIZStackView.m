//
//  BIZStackView.m
//  CultTourist
//
//  Created by IgorBizi@mail.ru on 15.05.14.
//  Copyright (c) 2014 IgorBizi@mail.ru. All rights reserved.
//


#import "BIZStackView.h"
#import "BIZStackViewItemData.h"


@interface BIZStackView ()
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@end


@implementation BIZStackView


#pragma mark - LifeCycle


- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (void)setup
{
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:self.tapGestureRecognizer];
    
    self.items = [NSMutableArray array];
}


#pragma mark - Getters/Setters


- (void)setDataSource:(id<BIZStackViewDataSource>)dataSource
{
    _dataSource = dataSource;
    [self reloadData];
}


#pragma mark - Methods


- (void)handleTap:(UILongPressGestureRecognizer *)recognizer
{
    static CGPoint initalTouchPosition;
    static CGRect initalViewRect;
    static UIView *touchesMoveView = nil;
    
    initalTouchPosition = [recognizer locationInView:self];
    UIView *selectedView = nil;
    [self findView:&selectedView atPoint:initalTouchPosition fromParent:self];
    if (selectedView) {
        touchesMoveView = selectedView;
        initalViewRect = touchesMoveView.frame;
        [UIView animateWithDuration:0.2
                         animations:^{
                             CGRect r =  initalViewRect;
                             r.origin.y -= 7;
                             touchesMoveView.frame = r;
                         }];
    }
    
    if (touchesMoveView) {
        CGPoint touchPos = [recognizer locationInView:self];
        CGRect frame = touchesMoveView.frame;
        frame.origin.y = initalViewRect.origin.y + (touchPos.y - initalTouchPosition.y);
        if([UIScreen mainScreen].bounds.size.height > frame.size.height)
            frame.size.height = initalViewRect.size.height + fabs(touchPos.y - initalTouchPosition.y);
        touchesMoveView.frame = frame;
    }
    
    NSInteger selectedIndex = [self indexByView:touchesMoveView];
    if ([self.stackViewDelegate stackView:self didSelectItemAtIndex:selectedIndex]) {
        [UIView animateWithDuration:0.5
                         animations:^{
                             touchesMoveView.frame = initalViewRect;
                         }];
    }
}

- (void)reloadData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (self.dataSource) {
            [self.items removeAllObjects];
            for(UIView *v in self.subviews)
            {
                if(![v isKindOfClass:[UISearchBar class]]) {
                    [v removeFromSuperview];
                }
            }
            CGFloat itemPosition = 44;
            for(int i = 0; i < [self.dataSource numberOfItemsInStackView:self]; i++)
            {
                UIView *item = [self.dataSource stackView:self itemForRowAtIndex:i];
                if (item) {
                    BIZStackViewItemData *itemData = [[BIZStackViewItemData alloc] init];
                    
                    CGRect rect = item.frame;
                    rect.origin.y = itemPosition;
                    rect.origin.x = (self.bounds.size.width - rect.size.width)/2;
                    [self addSubview:item];
                    
                    item.frame = rect;
                    itemPosition += [self.dataSource stackView:self heightForRowAtIndex:i];
                    
                    itemData.view = item;
                    itemData.frame = item.frame;
                    itemData.index = i;
                    [self.items addObject:itemData];
                }
            }
            [self setContentSize:CGSizeMake(self.bounds.size.width, itemPosition)];
        }
    });
}

- (void)restoreStateAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion
{
    [UIView animateWithDuration:(animated) ? 0.3 : 0
                     animations:^{
                         
                         if (self.dataSource) {
                             for (int i = 0; i < self.items.count; i++)
                             {
                                 BIZStackViewItemData *item = [self.items objectAtIndex:i];
                                 if (item) {
                                     item.view.frame = item.frame;
                                 }
                             }
                         }
                     } completion:^(BOOL finished) {
                         //self.clipsToBounds = YES;
                         if (completion) {
                             completion(finished);
                         }
                     }];
}

- (void)findView:(UIView **)visibleView atPoint:(CGPoint)pt fromParent:(UIView *)parentView
{
    UIView *applicationWindowView = self;
    
    if(!parentView) {
        parentView = self;
    }
    
    for(UIView *view in self.subviews)
    {
        if((view.superview != nil) && (view.hidden == NO) && (view.alpha > 0)) {
            CGPoint pointInView = [applicationWindowView convertPoint:pt toView:view];
            
            if([view pointInside:pointInView withEvent:nil]) {
                *visibleView = view;
            }
            //[self findView:visibleView atPoint:pt fromParent:view];
        }
    }
}

- (void)showFullScreenItemByView:(UIView *)view completion:(void (^)(BOOL finished))completion
{
    [self showFullScreenItemAtIndex:[self indexByView:view] completion:completion];
}

- (NSInteger)indexByView:(UIView *)view
{
    for (NSInteger i = 0; i < self.items.count; i++)
    {
        if([((BIZStackViewItemData *)[self.items objectAtIndex:i]).view isEqual:view]) {
            return i;
        }
    }
    return -1;
}

- (void)showFullScreenItemAtIndex:(NSInteger)index completion:(void (^)(BOOL finished))completion
{
    //self.clipsToBounds = NO;
    [UIView animateWithDuration:0.3
                     animations:^{
                         CGRect rect = [[UIScreen mainScreen] bounds];
                         rect.origin.y = -self.frame.origin.y + self.contentOffset.y;

                         ((BIZStackViewItemData *)[self.items objectAtIndex:index]).view.frame = rect;
                         for (NSInteger i = index + 1; i < self.items.count; i++)
                         {
                             BIZStackViewItemData *item = [self.items objectAtIndex:i];
                             item.view.frame = CGRectMake(item.view.frame.origin.x, item.view.frame.origin.y + self.bounds.size.height, item.view.frame.size.width, item.view.frame.size.height);
                         }
                     } completion:completion];
}

- (void)restoreItemAtIndex:(NSInteger)index completion:(void (^)(BOOL finished))completion
{
}


@end
