//
//  ABCSettingsAddress.m
//  your-dpd
//
//  Created by Richard Simkins on 01/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCSettingsAddress.h"

#import "AppDelegate.h"

@interface ABCSettingsAddress()
	@property (nonatomic) ABCDataAddress* dataAddress;
@end

@implementation ABCSettingsAddress

	- (CGFloat) SizePaddingLeft {
		return [AppDelegate SizePaddingFromSides];
	}

	- (CGFloat) SizePaddingRight {
		return [AppDelegate SizeIcon25];
	}

	- (instancetype)
		initWithDataAddress:(ABCDataAddress*)dataAddress
		andSizeView:(CGSize)sizeView {

		self = [super init];

		if (!self) return nil;

		[self setDataAddress:dataAddress];
		[self setSizeView:sizeView];
		[self initialise];

		return self;
	}

	- (void) initialise {
		CGSize sizeThatFits = CGSizeMake(
			[self sizeView].width - [self SizePaddingLeft] - [self SizePaddingRight],
			[self sizeView].height - ([AppDelegate SizePaddingFromSidesThin] * 2.0f));

		UIView* horizontalLine = [[UIView alloc] initWithFrame:CGRectMake(
			0.0f,
			0.0f,
			[self sizeView].width,
			[AppDelegate SizeSeparationThickness])];
		[self addSubview:horizontalLine];
		[horizontalLine setBackgroundColor:[AppDelegate ColourAppGreyLight]];

		NSAttributedString* labelText = [[NSAttributedString alloc]
			initWithString:[[self dataAddress] address]
			attributes:@{
				NSFontAttributeName:[AppDelegate FontRegularWithSize:12.0f],
				NSForegroundColorAttributeName:[AppDelegate ColourAppBlack],
			}];

		UILabel* label = [[UILabel alloc] init];
		[self addSubview:label];
		[label setAttributedText:labelText];

		CGSize labelSize = [label sizeThatFits:sizeThatFits];

		[label setFrame:CGRectMake(
			[self SizePaddingLeft],
			([self sizeView].height - labelSize.height) / 2.0f,
			labelSize.width,
			labelSize.height)];

		UIImageView* arrow = [[UIImageView alloc] initWithFrame:CGRectMake(
			[self sizeView].width - [AppDelegate SizeIcon25],
			([self sizeView].height - [AppDelegate SizeIcon25]) / 2.0f,
			[AppDelegate SizeIcon25],
			[AppDelegate SizeIcon25])];
		[self addSubview:arrow];
		[arrow setContentMode:UIViewContentModeScaleAspectFill];
		[arrow setImage:[UIImage imageNamed:@"settings-arrow.png"]];
	}
@end
