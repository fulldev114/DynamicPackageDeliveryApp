//
//  ABCYourProfile.m
//  your-dpd
//
//  Created by Richard Simkins on 02/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCYourProfile.h"

#import "ABCScrollView.h"
#import "ABCYourProfileEmail.h"
#import "ABCYourProfileFullname.h"
#import "ABCYourProfilePhone.h"
#import "ABCYourProfilePhoto.h"
#import "AppDelegate.h"

@interface ABCYourProfile()
	@property (nonatomic) UIView* cover;
	@property (nonatomic) ABCYourProfileEmail* email;
	@property (nonatomic) ABCYourProfileFullname* fullname;
	@property (nonatomic) ABCYourProfilePhone* phone;
	@property (nonatomic) ABCYourProfilePhoto* photo;
	@property (nonatomic) ABCScrollView* scrollView;
@end

@implementation ABCYourProfile
	- (instancetype) init {
		self = [super init];

		if (!self) return nil;

		[self setTitle:NSLocalizedString(@"Your Profile", nil)];

		return self;
	}

	- (void) viewDidLoad {
		[super viewDidLoad];

		[self setScrollView:[[ABCScrollView alloc] initWithBlockKeyboardStateChange:^{
			[self updateStatusBarHeightChangesWithDifference:0.0f];
		}]];
		[[self view] addSubview:[self scrollView]];

		[self setCover:[[UIView alloc] init]];
		[[self view] addSubview:[self cover]];
		[[self cover] setBackgroundColor:[UIColor
			colorWithRed:0.0f
			green:0.0f
			blue:0.0f
			alpha:0.3f]];
		[[self cover] setHidden:YES];

		[self setPhoto:[[ABCYourProfilePhoto alloc] init]];
		[[self scrollView] backgroundAddSubView:[self photo]];
		[[self scrollView] foregroundAddSubViewCollection:[[self photo] viewCollectionForScrollViewForeground]];
//			withSurrogateParent:[self photo]];

		[self setFullname:[[ABCYourProfileFullname alloc] initWithColumnLeftSize:CGSizeMake(
			[[self photo] sizeView].width,
			[[self photo] sizeView].width)]];
		[[self scrollView] backgroundAddSubView:[self fullname]];
		[[self scrollView] foregroundAddSubViewCollection:[[self fullname] viewCollectionForScrollViewForeground]];
//			withSurrogateParent:[self fullname]];

		[self setEmail:[[ABCYourProfileEmail alloc]
			initWithValue:@"chloe.smith@email.com"
			andBlockChange:^{
				[self updateStatusBarHeightChangesWithDifference:0.0f];
			}
			andBlockConfirm:^(NSString* pinNumber) {
				[[self cover] setHidden:NO];

				[NSTimer
					scheduledTimerWithTimeInterval:2.0f
					target:[NSBlockOperation blockOperationWithBlock:^{
						[[self email] confirmComplete];
						[[self cover] setHidden:YES];
						[self
							confirmWithTitle:NSLocalizedString(@"Email Successfully Verified", nil)
							andMessage:NSLocalizedString(@"Your email has been successfully verified and is now associated with this account.", nil)];
					}]
					selector:@selector(main)
					userInfo:nil
					repeats:NO];
			}]];
		[[self scrollView] backgroundAddSubView:[self email]];
		[[self scrollView] foregroundAddSubViewCollection:[[self email] viewCollectionForScrollViewForeground]];
//			withSurrogateParent:[self email]];

		[self setPhone:[[ABCYourProfilePhone alloc]
			initWithValue:@"07591234567"
			andBlockChange:^{
				[self updateStatusBarHeightChangesWithDifference:0.0f];
			}
			andBlockConfirm:^(NSString* pinNumber) {
				[[self cover] setHidden:NO];

				[NSTimer
					scheduledTimerWithTimeInterval:2.0f
					target:[NSBlockOperation blockOperationWithBlock:^{
						[[self phone] confirmComplete];
						[[self cover] setHidden:YES];
						[self
							confirmWithTitle:NSLocalizedString(@"Number Successfully Verified", nil)
							andMessage:NSLocalizedString(@"Your mobile number has been successfully verified and is now associated with this account.", nil)];
					}]
					selector:@selector(main)
					userInfo:nil
					repeats:NO];
			}]];
		[[self scrollView] backgroundAddSubView:[self phone]];
		[[self scrollView] foregroundAddSubViewCollection:[[self phone] viewCollectionForScrollViewForeground]];
//			withSurrogateParent:[self phone]];
	}

	- (void) updateStatusBarHeightChangesWithDifference:(CGFloat)difference {
		CGFloat top = [AppDelegate SizePaddingFromSides];

		// o Positioned in a column to the right of [self photo].
		[[self fullname]
			setPositionX:[AppDelegate SizePaddingFromSidesThin]
			andPositionY:top];

		top += [[self photo]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [AppDelegate SizePaddingFromSides];

		top += [[self email]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [AppDelegate SizePaddingFromSides];

		top += [[self phone]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [AppDelegate SizePaddingFromSides];

		[[self scrollView]
			setFrameHeight:[[self view] frame].size.height + difference
			andContentHeight:top];
		[[self cover] setFrame:CGRectMake(
			0.0f,
			0.0f,
			[[UIScreen mainScreen] bounds].size.height,
			[[self view] frame].size.height + difference)];
	}
@end
