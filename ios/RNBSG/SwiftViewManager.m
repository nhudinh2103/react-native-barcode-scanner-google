//
//  SwiftViewManager.m
//  RNSwift
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
