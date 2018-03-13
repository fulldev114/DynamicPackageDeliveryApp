//
//  ABCDataStatus.h
//  your-dpd
//
//  Created by Richard Simkins on 18/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCDataParcel.h"

@interface ABCDataStatus : NSObject
	@property (nonatomic) CGFloat fontSize;
	@property (nonatomic) BOOL highlight;

	- (instancetype) initWithDataParcel:(ABCDataParcel*)dataParcel;

	- (NSAttributedString*) attributedString;
@end