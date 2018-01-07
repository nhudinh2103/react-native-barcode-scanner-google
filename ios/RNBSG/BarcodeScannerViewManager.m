//
//  SwiftViewManager.m
//  RNSwift
//

#import <MapKit/MapKit.h>
#import "BarcodeScannerViewManager.h"
#import "RNBSG-Swift.h"

@implementation BarcodeScannerViewManager

RCT_EXPORT_MODULE()
RCT_EXPORT_VIEW_PROPERTY(onBarcodeRead, RCTBubblingEventBlock)


- (UIView *) view
{
  return [[BarcodeScannerView alloc] init];
}

@end
