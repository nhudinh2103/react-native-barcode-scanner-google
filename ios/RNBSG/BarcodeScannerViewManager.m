//
//  SwiftViewManager.m
//  RNSwift
//

#import "BarcodeScannerViewManager.h"
#import "RNBSG-Swift.h"

@implementation BarcodeScannerViewManager

RCT_EXPORT_MODULE()
RCT_EXPORT_VIEW_PROPERTY(onBarcodeRead, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(barcodeTypes, NSInteger)


- (UIView *) view
{
  return [[BarcodeScannerView alloc] init];
}

@end
