//
//  TWToolBar.h
//  TWToolBar
//
//  Created by Warut Surapat on 2/5/14.
//  Copyright (c) 2014 Taskworld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWToolBar : UIView

typedef NS_ENUM(NSUInteger, TWToolBarButtonStyle ) {
    TWToolBarPlainButtonStyle = 1,
    TWToolBarFullButtonStyle = 2
};

typedef NS_ENUM(NSUInteger, TWToolBarPosition) {
    TWToolBarPositionTop = 0,
    TWToolBarPositionRight = 1,
    TWToolBarPositionBottom = 2,
    TWToolBarPositionLeft = 3
};

@property (assign, nonatomic) CGFloat leadingSpace;
@property (assign, nonatomic) CGFloat trailingSpace;
@property (assign, nonatomic) CGFloat spaceBetweenItem;
@property (assign, nonatomic) NSUInteger count;
@property (assign, nonatomic) TWToolBarButtonStyle buttonStyle;
@property (assign, nonatomic) TWToolBarPosition position;

@property (strong, nonatomic) NSMutableArray* buttons;
@property (strong, nonatomic) NSArray* views;
@property (strong, nonatomic) NSArray* titles;
@property (strong, nonatomic) NSArray* imageNames;
@property (strong, nonatomic) NSArray* highLightedImageNames;
@property (strong, nonatomic) NSArray* itemActionBlocks;

@property (strong, nonatomic) UIColor* fontColor;
@property (strong, nonatomic) UIColor* highlightColor;

@property (weak, nonatomic) UIView* parentView;

// Convenience method
+ (TWToolBar*)toolBarWithTitles:(NSArray*)titles;
+ (TWToolBar*)toolBarWithTitles:(NSArray*)titles
                      withStyle:(TWToolBarButtonStyle)style;
+ (TWToolBar*)toolBarWithTitles:(NSArray*)titles
                 withImageNames:(NSArray*)imageNames
      withHighlightedImageNames:(NSArray*)highlightedImageNames;
+ (TWToolBar*)toolBarWithTitles:(NSArray*)titles
                 withImageNames:(NSArray*)imageNames
      withHighlightedImageNames:(NSArray*)highlightedImageNames
                      withStyle:(TWToolBarButtonStyle)style;
+ (TWToolBar*)toolBarWithViews:(NSArray *)views withFrame:(CGRect)frame;
+ (TWToolBar*)toolBarWithViews:(NSArray *)views
                     withFrame:(CGRect)frame
              withLeadingSpace:(CGFloat)leadingSpace
          withSpaceBetweenItem:(CGFloat)spaceBetweenItem;

- (void)addActionBlockForButtonAtIndex:(NSInteger)index;
- (void)setUp;
- (void)attachToView:(UIView*)view
          atPosition:(TWToolBarPosition)position
          completion:(void (^)(BOOL finished))completionBlock;
- (void)detachWithCompletion:(void (^)(BOOL finished))completionBlock;
- (CGFloat)buttonWidth;

- (instancetype)initWithFrame:(CGRect)frame andViews:(NSArray *)views;
// Designed initailizer
- (instancetype)initWithFrame:(CGRect)frame andViews:(NSArray *)views
              andLeadingSpace:(CGFloat)leadingSpace
          andSpaceBetweenItem:(CGFloat)spaceBetweenItem;

@end
