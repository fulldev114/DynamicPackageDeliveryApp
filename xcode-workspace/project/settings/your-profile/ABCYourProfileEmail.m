//
//  ABCYourProfileEmail.m
//  your-dpd
//
//  Created by Richard Simkins on 09/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCYourProfileEmail.h"

#import "ABCYourProfileEmailInput.h"
#import "ABCYourProfileEmailPin.h"
#import "ABCYourProfileEmailVerify.h"
#import "AppDelegate.h"

@interface ABCYourProfileEmail()
	@property (nonatomic, strong) BlockYourProfileEmailChange blockChange;
	@property (nonatomic, strong) BlockYourProfileEmailConfirm blockConfirm;
	@property (nonatomic) ABCYourProfileEmailInput* input;
	@property (nonatomic) ABCYourProfileEmailPin* pin;
	@property (nonatomic) NSUInteger state;
	@property (nonatomic) ABCYourProfileEmailVerify* verify;
@end

@implementation ABCYourProfileEmail
	- (NSUInteger) StateEditing {
		return 0;
	}

	- (NSUInteger) StateVerify {
		return 1;
	}

	- (NSUInteger) StatePin {
		return 2;
	}

	- (instancetype)
		initWithValue:(NSString*)value
		andBlockChange:(BlockYourProfileEmailChange)blockChange
		andBlockConfirm:(BlockYourProfileEmailConfirm)blockConfirm {

		self = [super init];

		if (!self) return nil;

		[self setBlockChange:blockChange];
		[self setBlockConfirm:blockConfirm];
		[self setState:[self StateEditing]];
		[self initialiseInput:value];
		[self initialiseVerify];
		[self initialisePin];

		return self;
	}

	- (void) confirmComplete {
		[self setState:[self StateEditing]];
		[[self input] commit];
		[[self pin] resign];
	}

	- (void) initialiseInput:(NSString*)inputValue {
		[self setInput:[[ABCYourProfileEmailInput alloc]
			initWithValue:inputValue
			andBlockEditStart:^() {
				[self setState:[self StateEditing]];
				[self blockChange]();
			}
			andBlockEditEnd:^() {
				if ([self state] == [self StatePin]) return;

				[self setState:[self StateEditing]];
				[[self input] revert];
				[self blockChange]();
			}
			andBlockChange:^(BOOL valueOriginal) {
				if (valueOriginal) {
					[self setState:[self StateEditing]];
				} else {
					[self setState:[self StateVerify]];
				}

				[self blockChange]();
			}]];
		[self addSubview:[self input]];
	}

	- (void) initialisePin {
		[self setPin:[[ABCYourProfileEmailPin alloc]
			initWithPaddingTop:[[self input] sizeView].height
			andBlockEditingEnd:^{
				[self setState:[self StateEditing]];
				[[self input] revert];
				[self blockChange]();
			}
			andBlockConfirm:^(NSString* pinNumber) {
				[self blockConfirm](pinNumber);
			}]];
		[self addSubview:[self pin]];
	}

	- (void) initialiseVerify {
		[self setVerify:[[ABCYourProfileEmailVerify alloc] initWithBlockTap:^{
			[self setState:[self StatePin]];
			[[self pin] pinReset];
			[self blockChange]();
		}]];
	}

	- (CGFloat)
		setPositionX:(CGFloat)x
		andPositionY:(CGFloat)y {

		CGFloat paddingTop = 0.0f;
		CGFloat sizeViewHeight = 0.0f;

		[[self input] setHidden:YES];
		[[self verify] setHidden:YES];
		[[self pin] setHidden:YES];

		if ([self state] == [self StateEditing]) {
			sizeViewHeight = [[self input] sizeView].height;
			[[self input] setHidden:NO];
		} else if ([self state] == [self StateVerify]) {
			paddingTop = [[self input] sizeView].height + [AppDelegate SizePaddingFromSidesThin];
			sizeViewHeight = [[self verify] sizeView].height;
			[[self input] setHidden:NO];
			[[self verify] setHidden:NO];
		} else if ([self state] == [self StatePin]) {
			paddingTop = [[self input] sizeView].height;
			sizeViewHeight = [[self pin] sizeView].height;
			[[self input] setHidden:NO];
			[[self pin] setHidden:NO];
		}

		[self setSizeView:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f),
			paddingTop + sizeViewHeight)];

		CGFloat height = [super
			setPositionX:x
			andPositionY:y];
		[[self input]
			setPositionX:x
			andPositionY:y];
		[[self verify]
			setPositionX:x
			andPositionY:y + paddingTop];
		[[self pin]
			setPositionX:x
			andPositionY:y + paddingTop];

		return height;
	}

	- (NSArray*) viewCollectionForScrollViewForeground {
		return @[
			[[self input] viewCollectionForScrollViewForeground],
			[[self verify] viewCollectionForScrollViewForeground],
			[[self pin] viewCollectionForScrollViewForeground],
		];
	}
@end
