//
//  ABCYourProfilePhoneInput.m
//  your-dpd
//
//  Created by Richard Simkins on 11/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCYourProfilePhoneInput.h"

#import "AppDelegate.h"

@interface ABCYourProfilePhoneInput()
	// # We can not rely on [self backgroundColor] to store the state since the background colour is
	//   determined from ABCYourProfileEmail depending on external state.
	@property (nonatomic) UIColor* backgroundColour;
	@property (nonatomic, strong) BlockYourProfilePhoneInputChange blockChange;
	@property (nonatomic, strong) BlockYourProfilePhoneInputEditEnd blockEditEnd;
	@property (nonatomic, strong) BlockYourProfilePhoneInputEditStart blockEditStart;
	@property (nonatomic) UIButton* button;
	// # We can not rely on UIButton::_hidden to store the state since the visibility [self button]
	//   is controlled from ABCYourProfileEmail depending on external state.
	@property (nonatomic) BOOL buttonHidden;
	@property (nonatomic) NSUInteger changeState;
	@property (nonatomic) UITextField* textField;
	@property (nonatomic) NSString* valueOriginal;
@end

@implementation ABCYourProfilePhoneInput
	- (NSUInteger) ChangeStateNone {
		return 0;
	}

	- (NSUInteger) ChangeStateValueNew {
		return 1;
	}

	- (NSUInteger) ChangeStateValueOld {
		return 2;
	}

	- (CGFloat) SizePaddingLeftIcon {
		return 55.0f;
	}

	- (CGFloat) SizePaddingLeftSeparator {
		return 88.0f;
	}

	- (CGFloat) SizePaddingLeftTextView {
		return 100.0f;
	}

	- (CGFloat) SizePaddingRightTextView {
		return 60.0f;
	}

	- (BOOL) ValueNew {
		return false;
	}

	- (BOOL) ValueOriginal {
		return true;
	}

	- (instancetype)
		initWithValue:(NSString*)value
		andBlockEditStart:(BlockYourProfilePhoneInputEditStart)blockEditStart
		andBlockEditEnd:(BlockYourProfilePhoneInputEditEnd)blockEditEnd
		andBlockChange:(BlockYourProfilePhoneInputChange)blockChange {

		self = [super init];

		if (!self) return nil;

		[self setBlockChange:blockChange];
		[self setBlockEditEnd:blockEditEnd];
		[self setBlockEditStart:blockEditStart];
		[self setValueOriginal:value];
		[self setSizeView:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f),
			48.0f)];
		[self initialise];

		return self;
	}

	- (void) change {
		if ([[self valueOriginal] isEqualToString:[[self textField] text]]) {
			if ([self changeState] != [self ChangeStateValueOld]) {
				[self setChangeState:[self ChangeStateValueOld]];
				[self blockChange]([self ValueOriginal]);
			}
		} else {
			if ([self changeState] != [self ChangeStateValueNew]) {
				[self setChangeState:[self ChangeStateValueNew]];
				[self blockChange]([self ValueNew]);
			}
		}
	}

	- (void) commit {
		[self setValueOriginal:[[self textField] text]];
		[self inputAppearanceDisabled];
	}

	- (void) inputAppearanceDisabled {
		[self setBackgroundColour:[AppDelegate ColourAppGrey]];
		[self setButtonHidden:NO];
		[[self textField] setEnabled:NO];
		[[self textField] setTextColor:[AppDelegate ColourAppGreyDark]];
	}

	- (void) inputAppearanceEnabled {
		[self setBackgroundColour:[UIColor whiteColor]];
		[self setButtonHidden:YES];
		[[self textField] setEnabled:YES];
		[[self textField] setTextColor:[AppDelegate ColourAppBlack]];
	}

	- (void) editingEnd {
		[self inputAppearanceDisabled];
		[self blockEditEnd]();
	}

	- (void) editingStart {
		[self inputAppearanceEnabled];
		[[self textField] becomeFirstResponder];
		[self blockEditStart]();
	}

	- (void) initialise {
		[self setTextField:[[UITextField alloc] init]];
		[[self textField]
			addTarget:self
			action:@selector(change)
			forControlEvents:UIControlEventEditingChanged];
		[[self textField]
			addTarget:self
			action:@selector(editingEnd)
			forControlEvents:UIControlEventEditingDidEnd];
//		[[self textField] setBackgroundColor:[UIColor yellowColor]];
		[[self textField] setFont:[AppDelegate FontRegularWithSize:12.0f]];
		[[self textField] setKeyboardType:UIKeyboardTypeNumberPad];
		[[self textField] setText:[self valueOriginal]];
		[self inputAppearanceDisabled];

		UIImageView* imageView = [[UIImageView alloc] init];
		[self addSubview:imageView];
		[imageView setContentMode:UIViewContentModeScaleAspectFill];
		[imageView setFrame:CGRectMake(
			([self SizePaddingLeftIcon] - [AppDelegate SizeIcon40]) / 2.0f,
			([self sizeView].height - [AppDelegate SizeIcon40]) / 2.0f,
			[AppDelegate SizeIcon40],
			[AppDelegate SizeIcon40])];
		[imageView setImage:[UIImage imageNamed:@"your-profile-email.png"]];

		[self setButton:[UIButton buttonWithType:UIButtonTypeCustom]];
		[[self button]
			addTarget:self
			action:@selector(editingStart)
			forControlEvents:UIControlEventTouchUpInside];
//		[[self button] setBackgroundColor:[UIColor cyanColor]];
		[[self button]
			setTitle:NSLocalizedString(@"Edit", nil)
			forState:UIControlStateNormal];
		[[self button]
			setTitleColor:[AppDelegate ColourAppRed]
			forState:UIControlStateNormal];
		[[[self button] titleLabel] setFont:[AppDelegate FontRegularWithSize:15.0f]];

		UILabel* label = [[UILabel alloc] init];
		[self addSubview:label];
		[label setFont:[AppDelegate FontRegularWithSize:12.0f]];
		[label setNumberOfLines:1];
		[label setText:NSLocalizedString(@"+44", nil)];
		[label setTextColor:[AppDelegate ColourAppGreyDark]];

		CGSize labelSize = [label sizeThatFits:CGSizeMake(
			[self SizePaddingLeftTextView],
			[self sizeView].height)];

		[label setFrame:CGRectMake(
			[self SizePaddingLeftIcon],
			([self sizeView].height - labelSize.height) / 2.0f,
			labelSize.width,
			labelSize.height)];

		UIView* view = [[UIView alloc] init];
		[self addSubview:view];
		[view setBackgroundColor:[AppDelegate ColourAppGreyDark]];
		[view setFrame:CGRectMake(
			[self SizePaddingLeftSeparator],
			[AppDelegate SizePaddingFromSidesThin],
			[AppDelegate SizeSeparationThickness],
			[self sizeView].height - ([AppDelegate SizePaddingFromSidesThin] * 2.0f))];
	}

	- (void) revert {
		[self setChangeState:[self ChangeStateNone]];
		[[self textField] setText:[self valueOriginal]];
	}

	- (void) setHidden:(BOOL)hidden {
		[super setHidden:hidden];
		[[self textField] setHidden:hidden];
		[[self button] setHidden:hidden];
	}

	- (CGFloat)
		setPositionX:(CGFloat)x
		andPositionY:(CGFloat)y {

		CGFloat height = [super
			setPositionX:0.0f
			andPositionY:0.0f];
		CGFloat buttonWidth;
		[UIView setAnimationsEnabled:NO];

		[self setBackgroundColor:[self backgroundColour]];

		if (![[self valueOriginal] isEqualToString:[[self textField] text]]) {
			[self setBackgroundColor:[UIColor whiteColor]];
		}

		if ([self buttonHidden]) {
			buttonWidth = [AppDelegate SizePaddingFromSidesThin];
			[[self button] setHidden:YES];
		} else {
			buttonWidth = [self SizePaddingRightTextView];
			[[self button] setFrame:CGRectMake(
				x + [self sizeView].width - [self SizePaddingRightTextView],
				y,
				[self SizePaddingRightTextView],
				[self sizeView].height)];
			[[self button] setHidden:NO];
		}

		[[self textField] setFrame:CGRectMake(
			x + [self SizePaddingLeftTextView],
			y,
			[self sizeView].width - [self SizePaddingLeftTextView] - buttonWidth,
			[self sizeView].height)];
		[UIView setAnimationsEnabled:YES];

		return height;
	}

	- (NSArray*) viewCollectionForScrollViewForeground {
		return @[
			[self button],
			[self textField],
		];
	}
@end
