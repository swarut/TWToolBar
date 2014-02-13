//
//  TWToolBar.m
//  TWToolBar
//
//  Created by Warut Surapat on 2/5/14.
//  Copyright (c) 2014 Taskworld. All rights reserved.
//

#import "TWToolBar.h"

const CGFloat kDefaultHeight = 44;
const CGFloat kDefaultWidth = 320;
const CGFloat kAnimationDuration = 0.5;

@interface TWToolBar()

@property (assign, nonatomic) CGFloat buttonWidth;

@end

@implementation TWToolBar

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor whiteColor];
  }
  return self;
}

+ (TWToolBar*)toolBarWithTitles:(NSArray*)titles {
  
  return nil;
}

+ (TWToolBar*)toolBarWithTitles:(NSArray*)titles
  withStyle:(TWToolBarButtonStyle)style {

  return nil;
}
+ (TWToolBar*)toolBarWithTitles:(NSArray*)titles
  withImageNames:(NSArray*)imageNames
  withHighlightedImageNames:(NSArray*)highlightedImageNames {
  
  return nil;
}
+ (TWToolBar*)toolBarWithTitles:(NSArray*)titles
  withImageNames:(NSArray*)imageNames
  withHighlightedImageNames:(NSArray*)highlightedImageNames
  withStyle:(TWToolBarButtonStyle)style {
  
  TWToolBar* toolBar = [[TWToolBar alloc] initWithFrame:CGRectMake(0, 0, kDefaultWidth, kDefaultHeight)];
  toolBar.buttonStyle = style;
  toolBar.titles = [titles mutableCopy];
  toolBar.imageNames = [imageNames mutableCopy];
  toolBar.highLightedImageNames = [highlightedImageNames mutableCopy];
  [toolBar setUp];
  
  return toolBar;
}

+ (TWToolBar*)toolBarWithViews:(NSArray *)views withFrame:(CGRect)frame {
  return [self toolBarWithViews:views withFrame:frame withLeadingSpace:0 withSpaceBetweenItem:0];
}

+ (TWToolBar*)toolBarWithViews:(NSArray *)views
  withFrame:(CGRect)frame
  withLeadingSpace:(CGFloat)leadingSpace
  withSpaceBetweenItem:(CGFloat)spaceBetweenItem {
  
  TWToolBar* toolBar = [[TWToolBar alloc] initWithFrame:frame];
  toolBar.views            = views;
  toolBar.leadingSpace     = leadingSpace;
  toolBar.trailingSpace    = leadingSpace;
  toolBar.spaceBetweenItem = spaceBetweenItem;
  
  [views enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL *stop) {
    UIView* view = [views objectAtIndex:index];
    view.frame = CGRectMake(
      toolBar.leadingSpace + index * (toolBar.buttonWidth + toolBar.spaceBetweenItem),
      0,
      toolBar.buttonWidth,
      toolBar.frame.size.height);
    [toolBar addSubview:view];
  }];
  return toolBar;
  
}

- (void)setUp {
  
  for (UIView* view in self.subviews) {
    [view removeFromSuperview];
  }
  
  // Preconfigure button style.
  switch (self.buttonStyle) {
    case TWToolBarPlainButtonStyle:
      self.leadingSpace     = 10;
      self.trailingSpace    = 10;
      self.spaceBetweenItem = 10;
      break;
    case TWToolBarFullButtonStyle:
      self.leadingSpace     = 0;
      self.trailingSpace    = 0;
      self.spaceBetweenItem = 0;
      self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 100);
      break;
  }
  
  [self.titles enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL *stop) {
    // Prepare button details.
    NSString* title = obj;
    NSString* imageName = [self.imageNames objectAtIndex:index];
    NSString* highlightedImageName = [self.highLightedImageNames objectAtIndex:index];
    
    UIButton* button = [self buttonWithTitle:title
      withImage:imageName
      withHighlightedImageName:highlightedImageName];
    
    // Bind touch handler.
    [button addTarget:self action:@selector(buttonTouchHandler:) forControlEvents:UIControlEventTouchUpInside];
    
    // Set button size and position.
    button.frame = CGRectMake(
      self.leadingSpace + index * (self.buttonWidth + self.spaceBetweenItem),
      0,
      self.buttonWidth,
      self.frame.size.height);
    NSLog(@"bitton = %@", button);
    [self.buttons addObject:button];
    
    [self addSubview:button];
  }];
  
}

- (void)buttonTouchHandler:(UIButton*)sender {
  NSUInteger index = [self.buttons indexOfObject:sender];
  void (^ablock)(void) = [self.itemActionBlocks objectAtIndex:index];
  if (ablock) {
    ablock();
  }
}

- (UIButton*)buttonWithTitle:(NSString*)title withImage:(NSString*)imageName
  withHighlightedImageName:(NSString*)highlightedImageName {
  
  UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
  CGFloat buttonSpacing = 6.0;
  
  switch (self.buttonStyle) {
    case TWToolBarPlainButtonStyle:
      button.backgroundColor = [UIColor grayColor];
      [button setTitle:title forState:UIControlStateNormal];
      [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
      break;
    
    case TWToolBarFullButtonStyle:
    {
      [button setTitle:title forState:UIControlStateNormal];
      [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
      
      UIImage* a = [UIImage imageNamed:imageName];
      
      [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
      [button setImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
            
      CGSize imageSize = a.size;
      button.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height + buttonSpacing), 0.0);
      
      CGSize titleSize = [title sizeWithAttributes:nil];//button.titleLabel.frame.size;
      button.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + buttonSpacing), 0.0, 0.0, - titleSize.width);
      
    }
      break;
      
    default:
      break;
  }
  
  return button;
}

- (void)addActionBlockForButtonAtIndex:(NSInteger)index {
  
}

- (void)attachToView:(UIView*)view
  atPosition:(TWToolBarPosition)position
  completion:(void (^)(BOOL finished))completionBlock {
  
  self.parentView = view;
  self.position = position;
  
  // Ensure that toolbar isn't a subview of current view.
  [self removeFromSuperview];
  
  switch (position) {
    case TWToolBarPositionTop:
      
      break;
    
    case TWToolBarPositionRight:
      break;
      
    case TWToolBarPositionBottom:
    {
      self.frame = CGRectMake(
        0,
        view.frame.size.height,
        self.frame.size.width,
        self.frame.size.height);
      
      [view addSubview:self];
      [UIView animateWithDuration:kAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.frame = CGRectMake(
          0,
          view.frame.size.height - self.frame.size.height,
          self.frame.size.width,
          self.frame.size.height);
      } completion:completionBlock];
      
    }
      break;
      
    case TWToolBarPositionLeft:
      break;
  }
}

- (void)detachWithCompletion:(void (^)(BOOL finished))completionBlock {
  
  switch (self.position) {
    case TWToolBarPositionTop:
      break;
    case TWToolBarPositionRight:
      break;
    case TWToolBarPositionBottom:
    {
      self.frame = CGRectMake(
        0,
        self.parentView.frame.size.height - self.frame.size.height,
        self.frame.size.width,
        self.frame.size.height);
      
      [self.parentView addSubview:self];
      [UIView animateWithDuration:kAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.frame = CGRectMake(
          0,
          self.parentView.frame.size.height,
          self.frame.size.width,
          self.frame.size.height);
      } completion:completionBlock];
      
    }

      break;
    case TWToolBarPositionLeft:
      break;
    default:
      break;
  }
}

- (NSArray*)buttons {
  if (!_buttons) {
    _buttons = [[NSMutableArray alloc] init];
  }
  return  _buttons;
}

- (CGFloat)buttonWidth {
  CGFloat gapLength = (self.count - 1) * self.spaceBetweenItem;
  if (self.count == 0) {
    return self.frame.size.width;
  }
  else {
    return (self.frame.size.width - gapLength - (2 * self.leadingSpace)) / self.count;
  }
}

- (NSUInteger)count {
  _count = 0;
  // Assuming that number of title reflect total item.
  if (self.titles) {
    _count = [self.titles count];
  }
  if (self.views) {
    _count = [self.views count];
  }
  return _count;
}
@end
