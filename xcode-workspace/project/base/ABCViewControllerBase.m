//
//  ABCViewControllerBase.m
//  your-dpd
//
//  Created by Richard Simkins on 07/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCViewControllerBase.h"
#import "AppDelegate.h"

@interface ABCViewControllerBase()
	@property (nonatomic, strong) BlockConfirm blockConfirm;
@end

@implementation ABCViewControllerBase
	- (void)
		alertView:(UIAlertView*)alertView
		clickedButtonAtIndex:(NSInteger)buttonIndex {

		if (buttonIndex == 1) {
			[self blockConfirm]();
		}
	}

	- (void) viewDidLoad {
		[super viewDidLoad];

		[[self view] setBackgroundColor:[AppDelegate ColourAppGreyLight]];
	}

	- (void) viewDidLayoutSubviews {
		[super viewDidLayoutSubviews];

		[self updateStatusBarHeightChangesWithDifference:0.0f];
		[AppDelegate currentViewControllerSet:self];
	}

	- (void)
		confirmWithTitle:(NSString*)title
		andMessage:(NSString*)message {

		NSString* action = NSLocalizedString(@"OK", nil);
		UIAlertController* alertController = [UIAlertController
			alertControllerWithTitle:title
			message:message
			preferredStyle:UIAlertControllerStyleAlert];

		// o Since we support iOS 7.
		if (alertController) {
			[alertController addAction:[UIAlertAction
				actionWithTitle:action
				style:UIAlertActionStyleDefault
				handler:nil]];
			[[self navigationController]
				presentViewController:alertController
				animated:YES
				completion:nil];
		} else {
			UIAlertView* alertView = [[UIAlertView alloc]
				initWithTitle:title
				message:message
				delegate:nil
				cancelButtonTitle:action
				otherButtonTitles:nil];
			[alertView show];
		}
	}

	- (void)
		confirmWithTitle:(NSString*)title
		andMessage:(NSString*)message
		andBlockConfirm:(BlockConfirm)blockConfirm {

		[self setBlockConfirm:blockConfirm];

		UIAlertController* alertController = [UIAlertController
			alertControllerWithTitle:title
			message:message
			preferredStyle:UIAlertControllerStyleAlert];

		// o Since we support iOS 7.
		if (alertController) {
			[alertController addAction:[UIAlertAction
				actionWithTitle:@"Cancel"
				style:UIAlertActionStyleCancel
				handler:^(UIAlertAction *action) {
				}]];
			[alertController addAction:[UIAlertAction
				actionWithTitle:@"Yes"
				style:UIAlertActionStyleDefault
				handler:^(UIAlertAction *action) {
					[self blockConfirm]();
				}]];

			[[self navigationController]
				presentViewController:alertController
				animated:YES
				completion:nil];
		} else {
			UIAlertView* alertView = [[UIAlertView alloc]
				initWithTitle:title
				message:message
				delegate:self
				cancelButtonTitle:@"Cancel"
				otherButtonTitles:@"Yes", nil];
			[alertView show];
		}
	}

	- (void)
		confirmWithTitle:(NSString*)title
		andMessage:(NSString*)message
		andCancel:(NSString*)cancel
		andDestructive:(NSString*)destructive
		andBlockConfirm:(BlockConfirm)blockConfirm {

		[self setBlockConfirm:blockConfirm];

		UIAlertController* alertController = [UIAlertController
			alertControllerWithTitle:title
			message:message
			preferredStyle:UIAlertControllerStyleAlert];

		// o Since we support iOS 7.
		if (alertController) {
			[alertController addAction:[UIAlertAction
				actionWithTitle:cancel
				style:UIAlertActionStyleCancel
				handler:^(UIAlertAction *action) {
				}]];
			[alertController addAction:[UIAlertAction
				actionWithTitle:destructive
				style:UIAlertActionStyleDestructive
				handler:^(UIAlertAction *action) {
					[self blockConfirm]();
				}]];

			[[self navigationController]
				presentViewController:alertController
				animated:YES
				completion:nil];
		} else {
			UIAlertView* alertView = [[UIAlertView alloc]
				initWithTitle:title
				message:message
				delegate:self
				cancelButtonTitle:cancel
				otherButtonTitles:destructive, nil];
			[alertView show];
		}
	}

	- (void) updateStatusBarHeightChangesWithDifference:(CGFloat)difference {
	}
@end
