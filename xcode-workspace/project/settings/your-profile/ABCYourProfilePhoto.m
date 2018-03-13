//
//  ABCYourProfilePhoto.m
//  your-dpd
//
//  Created by Richard Simkins on 02/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCYourProfilePhoto.h"

#import "AppDelegate.h"

@interface ABCYourProfilePhoto()
	@property (nonatomic) UIButton* edit;
@end

@implementation ABCYourProfilePhoto
	- (CGFloat) SizeLabelHeight {
		return 35.0f;
	}

	- (CGFloat) SizePhoto {
		return 88.0f;
	}

	- (instancetype) init {
		self = [super init];

		if (!self) return nil;

		CGFloat sizePhoto = [self SizePhoto] + ([AppDelegate SizePaddingFromSidesThin] * 2.0f);
		[self setSizeView:CGSizeMake(
			sizePhoto,
			sizePhoto + [self SizeLabelHeight])];
		[self initialise];

		return self;
	}

	- (void) initialise {
		UIView* view = [[UIView alloc] init];
		[self addSubview:view];
		[view setBackgroundColor:[UIColor whiteColor]];
		[view setFrame:CGRectMake(
			0.0f,
			0.0f,
			[self sizeView].width,
			[self sizeView].width)];

		UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"your-profile-photo-placeholder.png"]];
		[self addSubview:imageView];
		[imageView setContentMode:UIViewContentModeScaleAspectFill];
		[imageView setFrame:CGRectMake(
			[AppDelegate SizePaddingFromSidesThin],
			[AppDelegate SizePaddingFromSidesThin],
			[self SizePhoto],
			[self SizePhoto])];

		[self setEdit:[UIButton buttonWithType:UIButtonTypeCustom]];
		[[self edit]
			addTarget:self
			action:@selector(tap)
			forControlEvents:UIControlEventTouchUpInside];
//		[[self edit] setBackgroundColor:[UIColor cyanColor]];
		[[self edit]
			setTitle:NSLocalizedString(@"Edit photo", nil)
			forState:UIControlStateNormal];
		[[self edit]
			setTitleColor:[AppDelegate ColourAppRed]
			forState:UIControlStateNormal];
		[[[self edit] titleLabel] setFont:[AppDelegate FontRegularWithSize:12.0f]];
	}

	- (CGFloat)
		setPositionX:(CGFloat)x
		andPositionY:(CGFloat)y {

		CGFloat height = [super
			setPositionX:x
			andPositionY:y];
		[[self edit] setFrame:CGRectMake(
			x,
			y + [self sizeView].width,
			[self sizeView].width,
			[self SizeLabelHeight])];

		return height;
	}

	- (void) tap {
		NSLog(@"Edit photo");
	}

	- (NSArray*) viewCollectionForScrollViewForeground {
		return @[
			[self edit],
		];
	}
@end
