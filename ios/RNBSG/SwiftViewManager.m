//
//  SwiftViewManager.m
//  RNSwift
//

#import <MapKit/MapKit.h>
#import "SwiftViewManager.h"
#import "RNBSG-Swift.h"

@implementation SwiftViewManager

RCT_EXPORT_MODULE()
RCT_EXPORT_VIEW_PROPERTY(onBarcodeRead, RCTBubblingEventBlock)


- (UIView *) view
{
  return [[BarcodeScannerView alloc] init];
}

@end
