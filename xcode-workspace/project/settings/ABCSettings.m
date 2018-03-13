//
//  ABCSettings.m
//  your-dpd
//
//  Created by Richard Simkins on 01/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCSettings.h"

#import <MapKit/MapKit.h>

#import "ABCAddressEdit.h"
#import "ABCDataAddress.h"
#import "ABCSettingsAddressCollection.h"
#import "ABCSettingsAddressNew.h"
#import "ABCSettingsDanger.h"
#import "ABCSettingsProfile.h"
#import "ABCSettingsSection.h"
#import "ABCYourProfile.h"
#import "AppDelegate.h"

@interface ABCSettings()
	@property (nonatomic) ABCSettingsAddressCollection* addressCollection;
	@property (nonatomic) ABCSettingsAddressNew* addressNew;
	@property (nonatomic) ABCSettingsSection* addressSection;
	@property (nonatomic) ABCSettingsDanger* danger;
	@property (nonatomic) ABCSettingsSection* dangerSection;
	@property (nonatomic) ABCSettingsProfile* profile;
	@property (nonatomic) ABCSettingsSection* profileSection;
	@property (nonatomic) UIScrollView* scrollView;
@end

@implementation ABCSettings
	- (instancetype) init {
		self = [super init];

		if (!self) return nil;

//		[self test];

		return self;
	}

	- (void) viewDidLayoutSubviews {
		[super viewDidLayoutSubviews];
	}

	- (void) viewDidLoad {
		[super viewDidLoad];

		[self setScrollView:[[UIScrollView alloc] init]];
		[[self view] addSubview:[self scrollView]];

		[self setProfileSection:[[ABCSettingsSection alloc] initWithTitle:NSLocalizedString(@"Your Profile", nil)]];
		[[self scrollView] addSubview:[self profileSection]];

		[self setProfile:[[ABCSettingsProfile alloc] initWithBlock:^{
			ABCYourProfile* viewController = [[ABCYourProfile alloc] init];
			[[self navigationController]
				pushViewController:viewController
				animated:YES];
		}]];
		[[self scrollView] addSubview:[self profile]];

		[self setAddressSection:[[ABCSettingsSection alloc] initWithTitle:NSLocalizedString(@"Manage Your Delivery Address", nil)]];
		[[self scrollView] addSubview:[self addressSection]];

		[self setAddressCollection:[[ABCSettingsAddressCollection alloc]
			initWithDataAddressCollection:@[
				[[ABCDataAddress alloc] initWithNSDictionary:@{
					@"address":@"Home - 24 College Drive, Manchester"
				}],
				[[ABCDataAddress alloc] initWithNSDictionary:@{
					@"address":@"Other - 100 Alan Turing Way, Manchester"
				}],
			]
			andBlockRowSelect:^(ABCDataAddress* dataAddress) {
				ABCAddressEdit* viewController = [[ABCAddressEdit alloc] init];
				[[self navigationController]
					pushViewController:viewController
					animated:YES];
			}]];
		[[self scrollView] addSubview:[self addressCollection]];

		[self setAddressNew:[[ABCSettingsAddressNew alloc] initWithBlock:^{
		}]];
		[[self scrollView] addSubview:[self addressNew]];

		[self setDangerSection:[[ABCSettingsSection alloc] initWithTitle:NSLocalizedString(@"Danger Zone!", nil)]];
		[[self scrollView] addSubview:[self dangerSection]];

		[self setDanger:[[ABCSettingsDanger alloc] initWithBlock:^{
			[self
				confirmWithTitle:NSLocalizedString(@"Are you sure you want to delete your profile?", nil)
				andMessage:NSLocalizedString(@"Select 'Delete' to permanently delete your profile and its preferences?", nil)
				andCancel:@"Cancel"
				andDestructive:@"Delete"
				andBlockConfirm:^{
				}];
		}]];
		[[self scrollView] addSubview:[self danger]];
	}

	- (void) test {
CLLocationCoordinate2D destinationLocation;
destinationLocation.latitude = 53.3786329;
destinationLocation.longitude = -1.4632642;
MKPlacemark* destinationPlacemark = [[MKPlacemark alloc] initWithCoordinate:destinationLocation addressDictionary:nil];
MKMapItem* destination = [[MKMapItem alloc] initWithPlacemark:destinationPlacemark];
CLLocationCoordinate2D sourceLocation;
sourceLocation.latitude = 53.4014462;
sourceLocation.longitude = -1.5056171;
MKPlacemark* sourcePlacemark = [[MKPlacemark alloc] initWithCoordinate:sourceLocation addressDictionary:nil];
MKMapItem* source = [[MKMapItem alloc] initWithPlacemark:sourcePlacemark];
MKDirectionsRequest* request = [[MKDirectionsRequest alloc] init];
[request setSource:source];//[MKMapItem mapItemForCurrentLocation]];
[request setDestination:destination];
[request setTransportType:MKDirectionsTransportTypeAny]; // This can be limited to automobile and walking directions.
[request setRequestsAlternateRoutes:YES]; // Gives you several route options.
MKDirections* directions = [[MKDirections alloc] initWithRequest:request];
[directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse* response, NSError* error) {
if (!error) {
for (MKRoute* route in [response routes]) {
	for (MKRouteStep* routeStep in [route steps]) {
		NSLog(@"%@", [routeStep instructions]);
	}
	break;
//	NSLog(@"%@", [route advisoryNotices]);
//[myMapView addOverlay:[route polyline] level:MKOverlayLevelAboveRoads]; // Draws the route above roads, but below labels.
// You can also get turn-by-turn steps, distance, advisory notices, ETA, etc by accessing various route properties.
}
}
}];
	}

	- (void) updateStatusBarHeightChangesWithDifference:(CGFloat)difference {
		CGFloat top = [AppDelegate SizePaddingFromSidesThin];

		top += [[self profileSection]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [[self profile]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [ABCSettingsSection SizeMarginTop];

		top += [[self addressSection]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [[self addressCollection]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [AppDelegate SizePaddingFromSides];

		top += [[self addressNew]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [ABCSettingsSection SizeMarginTop];

		top += [[self dangerSection]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [[self danger]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [AppDelegate SizePaddingFromSides];

		[[self scrollView] setContentSize:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width,
			top)];
		[[self scrollView] setFrame:CGRectMake(
			0.0f,
			0.0f,
			[[UIScreen mainScreen] bounds].size.width,
			[[self view] frame].size.height + difference)];
	}
@end
