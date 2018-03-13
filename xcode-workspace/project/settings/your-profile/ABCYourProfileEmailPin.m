//
//  ABCYourProfileEmailPin.m
//  your-dpd
//
//  Created by Richard Simkins on 09/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCYourProfileEmailPin.h"

#import "AppDelegate.h"

@interface ABCYourProfileEmailPin()
	@property (nonatomic, strong) BlockYourProfileEmailPinConfirm blockConfirm;
	@property (nonatomic, strong) BlockYourProfileEmailPinEditingEnd blockEditingEnd;
	@property (nonatomic) UIButton* buttonResend;
	@property (nonatomic) UIView* forgiving;
	@property (nonatomic) UITextField* hiddenDeliberately;
	@property (nonatomic) CGFloat paddingTop;
	@property (nonatomic) NSArray* pinCollection;
	@property (nonatomic) NSUInteger pinIndex;
	@property (nonatomic) BOOL confirmPending;
@end

@implementation ABCYourProfileEmailPin
	- (NSUInteger) LimitPinCollection {
		return 6;
	}

	// # The event UIControlEventEditingChanged will not fire if [self hiddenDeliberately] is set to
	//   an empty string.
	- (NSString*) DummyPrefix {
		return @"dummy";
	}

	- (CGFloat) SizeButtonWidth {
		return 115.0f;
	}

	- (CGFloat) SizePinFieldPaddingLeft {
		return 92.0f;
	}

	- (CGFloat) SizePinFieldPaddingRight {
		return 55.0f;
	}

	- (CGFloat) SizePinLabelPaddingLeft {
		return 55.0f;
	}

	- (CGFloat) SizeSubviewHeight {
		return 48.0f;
	}

	- (instancetype)
		initWithPaddingTop:(CGFloat)paddingTop
		andBlockEditingEnd:(BlockYourProfileEmailPinEditingEnd)blockEditingEnd
		andBlockConfirm:(BlockYourProfileEmailPinConfirm)blockConfirm {

		self = [super init];

		if (!self) return nil;

		[self setBlockConfirm:blockConfirm];
		[self setBlockEditingEnd:blockEditingEnd];
		[self setConfirmPending:NO];
		[self setPaddingTop:paddingTop];
		[self setSizeView:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f),
			([self SizeSubviewHeight] * 2.0f) + [AppDelegate SizePaddingFromSidesThin])];
		[self initialise];

		return self;
	}

	- (void)
		button:(UIButton*)button
		titleSet:(NSString*)title {

		if ([title isEqualToString:@""]) {
			[button
				setImage:[UIImage imageNamed:@"your-profile-pin-placeholder.png"]
				forState:UIControlStateNormal];
			[button
				setTitle:@""
				forState:UIControlStateNormal];
		} else {
			[button
				setImage:nil
				forState:UIControlStateNormal];
			[button
				setTitle:title
				forState:UIControlStateNormal];
		}
	}

	- (void) change {
		NSString* value = @"";

		if ([[[self hiddenDeliberately] text] length] > [[self DummyPrefix] length]) {
			value = [[[self hiddenDeliberately] text] substringFromIndex:[[self DummyPrefix] length]];
		}

		if ([value isEqualToString:@""]) {
			if ([self pinIndex] > 0) {
				[self setPinIndex:[self pinIndex] - 1];
			}

			[self
				button:[[self pinCollection] objectAtIndex:[self pinIndex]]
				titleSet:@""];
		} else {
			[self
				button:[[self pinCollection] objectAtIndex:[self pinIndex]]
				titleSet:value];
			[self setPinIndex:[self pinIndex] + 1];

			if ([self pinIndex] == [self LimitPinCollection]) {
				NSString* pinNumber = @"";

				for (UIButton* button in [self pinCollection]) {
					pinNumber = [NSString stringWithFormat:@"%@%@", pinNumber, [[button titleLabel] text]];
				}

				[self setConfirmPending:YES];
				[[self hiddenDeliberately] resignFirstResponder];
				[self blockConfirm](pinNumber);
			}
		}

		[[self hiddenDeliberately] setText:[self DummyPrefix]];
	}

	- (void) editingEnd {
		if ([self confirmPending]) return;

		[self blockEditingEnd]();
	}

	- (void) initialise {
		UIView* view = [[UIView alloc] init];
		[self addSubview:view];
		[view setBackgroundColor:[UIColor whiteColor]];
		[view setFrame:CGRectMake(
			0.0f,
			0.0f,
			[self sizeView].width,
			[self SizeSubviewHeight])];

		UIImageView* imageView = [[UIImageView alloc] init];
		[self addSubview:imageView];
		[imageView setContentMode:UIViewContentModeScaleAspectFill];
		[imageView setFrame:CGRectMake(
			([self SizePinLabelPaddingLeft] - [AppDelegate SizeIcon40]) / 2.0f,
			([self SizeSubviewHeight] - [AppDelegate SizeIcon40]) / 2.0f,
			[AppDelegate SizeIcon40],
			[AppDelegate SizeIcon40])];
		[imageView setImage:[UIImage imageNamed:@"your-profile-pin.png"]];

		UILabel* labelPin = [[UILabel alloc] init];
		[self addSubview:labelPin];
		[labelPin setFont:[AppDelegate FontRegularWithSize:12.0f]];
		[labelPin setNumberOfLines:1];
		[labelPin setText:NSLocalizedString(@"PIN", nil)];
		[labelPin setTextColor:[AppDelegate ColourAppBlack]];

		CGSize labelPinSize = [labelPin sizeThatFits:CGSizeMake(
			[self sizeView].width,
			[self SizeSubviewHeight])];

		[labelPin setFrame:CGRectMake(
			[self SizePinLabelPaddingLeft],
			([self SizeSubviewHeight] - labelPinSize.height) / 2.0f,
			labelPinSize.width,
			labelPinSize.height)];

		UILabel* labelCheck = [[UILabel alloc] init];
		[self addSubview:labelCheck];
		[labelCheck setFont:[AppDelegate FontRegularWithSize:12.0f]];
		[labelCheck setNumberOfLines:0];
		[labelCheck setText:NSLocalizedString(@"PIN sent\nPlease check your email", nil)];
		[labelCheck setTextColor:[AppDelegate ColourAppBlack]];

		CGSize labelCheckSize = [labelCheck sizeThatFits:CGSizeMake(
			[self sizeView].width - [self SizeButtonWidth],
			[self SizeSubviewHeight])];

		[labelCheck setFrame:CGRectMake(
			([self sizeView].width - [self SizeButtonWidth] - labelCheckSize.width) / 2.0f,
			[self SizeSubviewHeight] + [AppDelegate SizePaddingFromSidesThin] + (([self SizeSubviewHeight] - labelCheckSize.height) / 2.0f),
			labelCheckSize.width,
			labelCheckSize.height)];

		[self setButtonResend:[UIButton buttonWithType:UIButtonTypeCustom]];
		[[self buttonResend]
			addTarget:self
			action:@selector(tapResend)
			forControlEvents:UIControlEventTouchUpInside];
		[[self buttonResend] setBackgroundColor:[AppDelegate ColourAppRed]];
		[[self buttonResend]
			setTitle:NSLocalizedString(@"Resend PIN", nil)
			forState:UIControlStateNormal];
		[[self buttonResend]
			setTitleColor:[UIColor whiteColor]
			forState:UIControlStateNormal];
		[[[self buttonResend] titleLabel] setFont:[AppDelegate FontRegularWithSize:16.0f]];

		[self setForgiving:[[UIView alloc] init]];
/*		[[self forgiving] setBackgroundColor:[UIColor
			colorWithRed:CGColorGetComponents([UIColor magentaColor].CGColor)[0]
			green:CGColorGetComponents([UIColor magentaColor].CGColor)[1]
			blue:CGColorGetComponents([UIColor magentaColor].CGColor)[2]
			alpha:0.5f]];*/

		[self setHiddenDeliberately:[[UITextField alloc] init]];
		[[self hiddenDeliberately]
			addTarget:self
			action:@selector(change)
			forControlEvents:UIControlEventEditingChanged];
		[[self hiddenDeliberately]
			addTarget:self
			action:@selector(editingEnd)
			forControlEvents:UIControlEventEditingDidEnd];
//		[[self hiddenDeliberately] setBackgroundColor:[UIColor yellowColor]];
		[[self hiddenDeliberately] setFont:[AppDelegate FontRegularWithSize:12.0f]];
		[[self hiddenDeliberately] setHidden:YES];
		[[self hiddenDeliberately] setKeyboardType:UIKeyboardTypeNumberPad];

		NSMutableArray* collection = [[NSMutableArray alloc] init];

		for (NSUInteger i = 0; i < [self LimitPinCollection]; i++) {
			UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
			[collection addObject:button];
			[button
				addTarget:self
				action:@selector(tapPin:)
				forControlEvents:UIControlEventTouchUpInside];
			[[button imageView] setContentMode:UIViewContentModeScaleAspectFit];
//			[button setBackgroundColor:[UIColor cyanColor]];
			[button
				setTitleColor:[AppDelegate ColourAppBlack]
				forState:UIControlStateNormal];
		}

		[self setPinCollection:collection];
	}

	- (void) pinReset {
		for (UIButton* button in [self pinCollection]) {
			[self
				button:button
				titleSet:@""];
		}

		[[self hiddenDeliberately] setText:[self DummyPrefix]];
		[[self hiddenDeliberately] becomeFirstResponder];
		[self setPinIndex:0];
	}

	- (void) resign {
		[self setConfirmPending:NO];
		[self blockEditingEnd]();
		//[[self hiddenDeliberately] resignFirstResponder];
	}

	- (void) setHidden:(BOOL)hidden {
		[super setHidden:hidden];
		[[self buttonResend] setHidden:hidden];
		[[self forgiving] setHidden:hidden];

		for (UITextField* textField in [self pinCollection]) {
			[textField setHidden:hidden];
		}
	}

	- (CGFloat)
		setPositionX:(CGFloat)x
		andPositionY:(CGFloat)y {

		CGFloat height = [super
			setPositionX:0.0f
			andPositionY:[self paddingTop]];

		[[self buttonResend] setFrame:CGRectMake(
			x + [self sizeView].width - [self SizeButtonWidth],
			y + [self SizeSubviewHeight] + [AppDelegate SizePaddingFromSidesThin],
			[self SizeButtonWidth],
			[self SizeSubviewHeight])];
		// o So that scroll offset works.
		[[self hiddenDeliberately] setFrame:[[self buttonResend] frame]];

		[[self forgiving] setFrame:CGRectMake(
			x,
			y,
			[self sizeView].width,
			[self SizeSubviewHeight])];

		for (NSUInteger i = 0; i < [self LimitPinCollection]; i++) {
			CGFloat availableWidth = [self sizeView].width - [self SizePinFieldPaddingLeft] - [self SizePinFieldPaddingRight];
			CGFloat separationWidth = availableWidth - ([AppDelegate SizeIcon18] * [self LimitPinCollection]);
			separationWidth	/= [self LimitPinCollection] - 1;
			[[[self pinCollection] objectAtIndex:i] setFrame:CGRectMake(
				x + [self SizePinFieldPaddingLeft] + (([AppDelegate SizeIcon18] + separationWidth) * i),
				y,
				[AppDelegate SizeIcon18],
				[self SizeSubviewHeight])];
		}

		return height;
	}

	- (void) tapResend {
		for (UIButton* button in [self pinCollection]) {
			[self
				button:button
				titleSet:@""];
		}

		[self setPinIndex:0];
	}

	- (void) tapPin:(UIButton*)eventButton {
		NSUInteger eventIndex = 0;

		for (UIButton* button in [self pinCollection]) {
			if ([button isEqual:eventButton]) break;

			eventIndex++;
		}

		// o Not a pin number button.
		if (eventIndex >= [[self pinCollection] count]) return;

		NSUInteger pinIndex = 0;
		BOOL pinIndexSet = NO;

		// 0 Set [self pinIndex] to the first empty button that is less than or equal to eventIndex
		//   and empty the button. Empty the remaining buttons.
		for (UIButton* button in [self pinCollection]) {
			if (pinIndex > eventIndex) {
				[self
					button:button
					titleSet:@""];
			} else if (pinIndex == eventIndex) {
				if (!pinIndexSet) {
					[self setPinIndex:pinIndex];
					pinIndexSet = YES;
				}

				[self
					button:button
					titleSet:@""];
			} else {
				if ([button currentTitle] == (id)[NSNull null]
					|| [[button currentTitle] length] == 0
					|| [[button currentTitle] isEqualToString:@""]) {

					if (!pinIndexSet) {
						[self setPinIndex:pinIndex];
						pinIndexSet = YES;
					}

					[self
						button:button
						titleSet:@""];
				}
			}

			pinIndex++;
		}
	}

	- (NSArray*) viewCollectionForScrollViewForeground {
		NSMutableArray* collection = [[NSMutableArray alloc] init];
		[collection addObject:[self buttonResend]];
		[collection addObject:[self forgiving]];
		[collection addObject:[self hiddenDeliberately]];

		for (UITextField* textField in [self pinCollection]) {
			[collection addObject:textField];
		}

		return collection;
	}
@end
