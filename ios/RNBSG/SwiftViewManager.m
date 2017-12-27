//
//  SwiftViewManager.m
//  RNSwift
//
//  Created by Apel Yl on 21/12/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//
#import <MapKit/MapKit.h>
#import "SwiftViewManager.h"
#import "RNBSG-Swift.h"

@implementation SwiftViewManager

RCT_EXPORT_MODULE()
RCT_EXPORT_VIEW_PROPERTY(text, NSString)

- (UIView *) view
{
  return [[SwiftView alloc] init];
}

@end
