//
//  ABCScrollView.m
//  your-dpd
//
//  Created by Richard Simkins on 08/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCScrollView.h"

#import "AppDelegate.h"

@interface ABCScrollView()
	@property (nonatomic) UIView* background;
	@property (nonatomic, strong) BlockScrollViewKeyboardStateChange blockKeyboardStateChange;
	@property (nonatomic) UIView* foreground;
	@property (nonatomic) UIView* foregroundFirstResponderLast;
	@property (nonatomic) UIButton* keyboardDismiss;
	@property (nonatomic) CGSize keyboardSize;
@end

@implementation ABCScrollView
	- (CGFloat) DelayContentOffset {
		return 0.3f;
	}

	- (void) dealloc {
		[[NSNotificationCenter defaultCenter]
			removeObserver:self
			name:UIKeyboardWillHideNotification
			object:nil];
		[[NSNotificationCenter defaultCenter]
			removeObserver:self
			name:UIKeyboardWillShowNotification
			object:nil];
	}

	- (instancetype) initWithBlockKeyboardStateChange:(BlockScrollViewKeyboardStateChange)blockKeyboardStateChange {
		self = [super init];

		if (!self) return nil;

		[self setBlockKeyboardStateChange:blockKeyboardStateChange];
		[self setKeyboardSize:CGSizeZero];
		[[NSNotificationCenter defaultCenter]
			addObserver:self
			selector:@selector(keyboardWillShow:)
			name:UIKeyboardWillShowNotification object:nil];
		[[NSNotificationCenter defaultCenter]
			addObserver:self
			selector:@selector(keyboardWillHide:)
			name:UIKeyboardWillHideNotification object:nil];
		[self initialise];

		return self;
	}

	- (void) textViewDidBeginEditing:(UITextView*)textView {
		[self editingDidBegin:textView];
	}

	- (void) textViewDidChange:(UITextView*)textView {
		[self editingDidBegin:textView];
	}

	- (void) backgroundAddSubView:(UIView*)subView {
		[[self background] addSubview:subView];
	}

	- (void) editingDidBegin:(id)sender {
		[self setForegroundFirstResponderLast:sender];

		// o Initially delay changing offset until keyboard has appeared.
		if (CGSizeEqualToSize([self keyboardSize], CGSizeZero)) return;

		[self setScrollEnabled:NO];
		CGFloat available = [self contentSize].height - [self frame].size.height;

		if (available < 0.0f) {
			available = 0.0f;
		}

		[UIView
			animateWithDuration:[self DelayContentOffset]
			animations:^{
				[self setContentOffset:CGPointMake(
					[self contentOffset].x,
					[sender frame].origin.y > available
						? available
						: [sender frame].origin.y)];
			}];
	}

	- (void) foregroundAddSubViewCollection:(NSArray*)subViewCollection {
		for (id subViewOrArray in subViewCollection) {
			if ([subViewOrArray isKindOfClass:[NSArray class]]) {
				[self foregroundAddSubViewCollection:subViewOrArray];

				continue;
			}

			[[self foreground] addSubview:subViewOrArray];

			if ([subViewOrArray isKindOfClass:[UITextField class]]) {
				[subViewOrArray
					addTarget:self
					action:@selector(editingDidBegin:)
					forControlEvents:UIControlEventEditingChanged];
				[subViewOrArray
					addTarget:self
					action:@selector(editingDidBegin:)
					forControlEvents:UIControlEventEditingDidBegin];
			}

			if ([subViewOrArray isKindOfClass:[UITextView class]]) {
				[subViewOrArray setDelegate:self];
			}

			if ([subViewOrArray isKindOfClass:[UIButton class]]) {
				[subViewOrArray
					addTarget:self
					action:@selector(editingDidBegin:)
					forControlEvents:UIControlEventTouchUpInside];
			}
		}
	}

	- (void) keyboardWillHide:(NSNotification*)notification {
		[self setKeyboardSize:CGSizeZero];
		[self blockKeyboardStateChange]();
	}

	- (void) keyboardWillShow:(NSNotification*)notification {
		[self setKeyboardSize:[[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size];
		[self blockKeyboardStateChange]();
		[self editingDidBegin:[self foregroundFirstResponderLast]];
	}

	- (void) initialise {
		[self setBackground:[[UIView alloc] init]];
		[self addSubview:[self background]];

		[self setForeground:[[UIView alloc] init]];
		[self addSubview:[self foreground]];

		[self setKeyboardDismiss:[UIButton buttonWithType:UIButtonTypeCustom]];
		[[self foreground] addSubview:[self keyboardDismiss]];
		[[self keyboardDismiss]
			addTarget:self
			action:@selector(tapKeyboardDismiss)
			forControlEvents:UIControlEventTouchUpInside];
/*		[[self keyboardDismiss] setBackgroundColor:[UIColor
			colorWithRed:0.0f
			green:1.0f
			blue:0.0f
			alpha:0.5f]];*/
	}

	- (void)
		setFrameHeight:(CGFloat)frameHeight
		andContentHeight:(CGFloat)contentHeight {

		[self setContentSize:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width,
			contentHeight)];

		[self setFrame:CGRectMake(
			0.0f,
			0.0f,
			[[UIScreen mainScreen] bounds].size.width,
			frameHeight - [self keyboardSize].height)];

		CGRect contentFrame = CGRectMake(
			0.0f,
			0.0f,
			[self contentSize].width,
			[self contentSize].height);
		[[self background] setFrame:contentFrame];
		[[self foreground] setFrame:contentFrame];
		[[self keyboardDismiss] setFrame:contentFrame];
	}

	- (void) tapKeyboardDismiss {
		[self setScrollEnabled:YES];

		for (UIView* view in [[self foreground] subviews]) {
			[view resignFirstResponder];
		}
	}
@end
