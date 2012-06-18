//
//  CustomSegmentedControl.h
//  42qu
//
//  Created by Alex Rezit on 12-6-16.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomSegmentedControl;

@protocol CustomSegmentedControlDelegate <NSObject>

- (void)customSegmentedControl:(CustomSegmentedControl *)customSegmentedControl didSelectItemAtIndex:(NSUInteger)index;

@end

@interface CustomSegmentedControl : UIView

typedef enum {
    SegmentedControlAnimationTypeFade = 0,
    SegmentedControlAnimationTypeMove
} SegmentedControlAnimationType;

@property (nonatomic, assign) id<CustomSegmentedControlDelegate> delegate;

@property (nonatomic, assign) SegmentedControlAnimationType animationType;

@property (nonatomic, strong) NSArray *buttons;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *highlightedTitles;
@property (nonatomic, strong) NSArray *selectedTitles;
@property (nonatomic, strong) UIImage *dividerImage;
@property (nonatomic, strong) UIImage *highlightedBackgroundImage;
@property (nonatomic, strong) UIImage *selectedBackgroundImage;
@property (nonatomic, strong) UIView *highlightedBackgroundView;
@property (nonatomic, strong) UIView *selectedBackgroundView;

- (id)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles andHighlightedTitles:(NSArray *)highlightedTitles andSelectedTitles:(NSArray *)selectedTitles andBackgroundImage:(UIImage *)backgroundImage andDividerImage:(UIImage *)dividerImage andHighlightedBackgroundImage:(UIImage *)highlightedBackgroundImage andSelectedBackgroundImage:(UIImage *)selectedBackgroundImage;

@end
