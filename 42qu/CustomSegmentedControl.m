//
//  CustomSegmentedControl.m
//  42qu
//
//  Created by Alex Rezit on 12-6-16.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import "CustomSegmentedControl.h"
#import <QuartzCore/QuartzCore.h>

@implementation CustomSegmentedControl

@synthesize delegate = _delegate;

@synthesize animationType = _animationType;

@synthesize buttons = _buttons;

@synthesize titles = _titles;
@synthesize images = _images;
@synthesize highlightedTitles = _highlightedTitles;
@synthesize selectedTitles = _selectedTitles;
@synthesize dividerImage = _dividerImage;
@synthesize highlightedBackgroundImage = _highlightedBackgroundImage;
@synthesize selectedBackgroundImage = _selectedBackgroundImage;
@synthesize highlightedBackgroundView = _highlightedBackgroundView;
@synthesize selectedBackgroundView = _selectedBackgroundView;

@synthesize selectedIndex = _selectedIndex;

#pragma mark - External

- (NSUInteger)numberOfButtons
{
    return _buttons.count;
}

- (void)selectButtonAtIndex:(NSUInteger)index
{
    [self selectButton:[_buttons objectAtIndex:index]];
}

- (void)moveSelectedBackgroundToOffset:(CGFloat)offset
{
    CGRect selectedBackgroundFrame = _selectedBackgroundView.frame;
    selectedBackgroundFrame.origin.x = offset;
    _selectedBackgroundView.frame = selectedBackgroundFrame;
}

#pragma mark - Actions

- (void)highlightButton:(UIButton *)button
{
    for (UIButton *oneButton in _buttons) {
        if (button == oneButton) {
            _highlightedBackgroundView.frame = oneButton.frame;
            CATransition *transition = [CATransition animation];
            transition.type = kCATransitionFade;
            transition.duration = 0.15f;
            [self.layer addAnimation:transition forKey:nil];
            [UIView animateWithDuration:0.15f animations:^{
                _highlightedBackgroundView.hidden = NO;
            }];
        }
    }
}

- (void)highlightButtonCancel:(UIButton *)button
{
    for (UIButton *oneButton in _buttons) {
        if (button == oneButton) {
            _highlightedBackgroundView.frame = oneButton.frame;
            CATransition *transition = [CATransition animation];
            transition.type = kCATransitionFade;
            transition.duration = 0.15f;
            [self.layer addAnimation:transition forKey:nil];
            [UIView animateWithDuration:0.15f animations:^{
                _highlightedBackgroundView.hidden = YES;
            }];
        }
    }
}

- (void)selectButton:(UIButton *)button
{
    for (UIButton *oneButton in _buttons) {
        if (button == oneButton) {
            _selectedIndex = [_buttons indexOfObject:oneButton];
            if (_animationType == SegmentedControlAnimationTypeFade) {
                CATransition *transition = [CATransition animation];
                transition.type = kCATransitionFade;
                transition.duration = 0.2f;
                [self.layer addAnimation:transition forKey:nil];
                _selectedBackgroundView.hidden = YES;
                _selectedBackgroundView.frame = oneButton.frame;
                [UIView animateWithDuration:0.2f animations:^{
                    oneButton.selected = YES;
                    _selectedBackgroundView.hidden = NO;
                    _highlightedBackgroundView.hidden = YES;
                }];
            } else if (_animationType == SegmentedControlAnimationTypeMove) {
                [UIView animateWithDuration:0.2f animations:^{
                    oneButton.selected = YES;
                    _selectedBackgroundView.frame = oneButton.frame;
                    _highlightedBackgroundView.hidden = YES;
                }];
            } else {
                oneButton.selected = YES;
                _selectedBackgroundView.frame = oneButton.frame;
                _highlightedBackgroundView.hidden = YES;
            }
        } else {
            oneButton.selected = NO;
        }
    }
}

- (void)buttonTouchUpInside:(UIButton *)button
{
    [self selectButton:button];
    [self.delegate customSegmentedControl:self didSelectButtonAtIndex:_selectedIndex];
}

- (void)buttonTouchedDown:(UIButton *)button
{
    [self highlightButton:button];
}

- (void)buttonTouchedOther:(UIButton *)button
{
    [self highlightButtonCancel:button];
}

#pragma mark - Life cycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles andImages:(NSArray *)images andHighlightedTitles:(NSArray *)highlightedTitles andSelectedTitles:(NSArray *)selectedTitles andBackgroundImage:(UIImage *)backgroundImage andDividerImage:(UIImage *)dividerImage andHighlightedBackgroundImage:(UIImage *)highlightedBackgroundImage andSelectedBackgroundImage:(UIImage *)selectedBackgroundImage
{
    self = [super initWithFrame:frame];
    if (self) {
        _animationType = SegmentedControlAnimationTypeMove;
        // Set the attributes
        self.titles = titles;
        self.images = images;
        self.highlightedTitles = highlightedTitles;
        self.selectedTitles = selectedTitles;
        self.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
        self.dividerImage = dividerImage;
        self.highlightedBackgroundImage = highlightedBackgroundImage;
        self.selectedBackgroundImage = selectedBackgroundImage;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [_buttons release];
    [_titles release];
    [_images release];
    [_highlightedTitles release];
    [_selectedTitles release];
    [_dividerImage release];
    [_highlightedBackgroundImage release];
    [_selectedBackgroundImage release];
    [_highlightedBackgroundView release];
    [_selectedBackgroundView release];
    [super dealloc];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (_titles.count > 0) { // When the number of buttons > 0, generate the segmented control
        if (_images.count && _titles.count != _images.count) { // When titles and images not match, return an empty view
            NSLog(@"Custom Segmented Control: Titles and images not match. ");
        }
        if ((_highlightedTitles.count && _titles.count != _highlightedTitles.count) || (_selectedTitles.count && _titles.count != _selectedTitles.count)) { // When titles and highlighted/selected titles not match, return an empty view
            NSLog(@"Custom Segmented Control: Titles and highlighted/selected titles not match. ");
            return;
        }
    } else { // When the titles is empty, return an empty view
        NSLog(@"Custom Segmented Control: Titles empty. ");
        return;
    }
    
    // Calculate the size
    CGRect frame = self.frame;
    CGFloat dividerWidth = _dividerImage?_dividerImage.size.width:0;
    CGFloat height = frame.size.height;
    CGFloat buttonWidth = (frame.size.width - dividerWidth * (_titles.count - 1)) / _titles.count;
    
    // Initialize horizontal offset
    CGFloat horizontalOffset = 0;
    
    // Create and add buttons
    NSMutableArray *buttons = [[NSMutableArray alloc] initWithCapacity:_titles.count];
    for (NSUInteger i = 0; i < _titles.count; i++) {
        // Button
        UIButton *button = [[[UIButton alloc] initWithFrame:CGRectMake(horizontalOffset, 0, buttonWidth, height)] autorelease];
        [button setTitle:[_titles objectAtIndex:i] forState:UIControlStateNormal];
        if (_images.count) {
            [button setImage:[_images objectAtIndex:i] forState:UIControlStateNormal];
        }
        if (_highlightedTitles.count) {
            [button setTitle:[_highlightedTitles objectAtIndex:i] forState:UIControlStateHighlighted];
        }
        if (_selectedTitles.count) {
            [button setTitle:[_selectedTitles objectAtIndex:i] forState:UIControlStateSelected];
        }
        [button addTarget:self action:@selector(buttonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(buttonTouchedDown:) forControlEvents:UIControlEventTouchDown];
        [button addTarget:self action:@selector(buttonTouchedOther:) forControlEvents:UIControlEventTouchUpOutside];
        [button addTarget:self action:@selector(buttonTouchedOther:) forControlEvents:UIControlEventTouchDragInside];
        [button addTarget:self action:@selector(buttonTouchedOther:) forControlEvents:UIControlEventTouchDragOutside];
        [buttons addObject:button];
        [self addSubview:button];
        horizontalOffset += buttonWidth;
        
        // Divider
        if (_dividerImage && i != _titles.count - 1) {
            UIView *dividerView = [[[UIView alloc] initWithFrame:CGRectMake(horizontalOffset, 0, dividerWidth, height)] autorelease];
            dividerView.backgroundColor = [UIColor colorWithPatternImage:_dividerImage];
            [self addSubview:dividerView];
            horizontalOffset += dividerWidth;
        }
    }
    self.buttons = buttons;
    [buttons release];
    
    // Initialize background views
    self.highlightedBackgroundView = [[UIImageView alloc] initWithFrame:[(UIButton *)[_buttons objectAtIndex:0] frame]];
    _highlightedBackgroundView.backgroundColor = [UIColor colorWithPatternImage:_highlightedBackgroundImage];
    _highlightedBackgroundView.hidden = YES;
    [self addSubview:_highlightedBackgroundView];
    
    self.selectedBackgroundView = [[UIImageView alloc] initWithFrame:[(UIButton *)[_buttons objectAtIndex:0] frame]];
    _selectedBackgroundView.backgroundColor = [UIColor colorWithPatternImage:_selectedBackgroundImage];
    [self addSubview:_selectedBackgroundView];
    [self sendSubviewToBack:_highlightedBackgroundView];
    [self sendSubviewToBack:_selectedBackgroundView];
    
    // Select the first button
    [self selectButton:[_buttons objectAtIndex:0]];
}

@end
