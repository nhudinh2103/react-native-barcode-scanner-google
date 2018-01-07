//
//  SwiftViewObjC.h
//  RNBSG
//

#import <UIKit/UIKit.h>
#import <React/RCTComponent.h>

@interface BarcodeScannerViewObjC : UIView

@property (nonatomic, copy) RCTBubblingEventBlock onBarcodeRead;

//Usual view stuff to override
- (void)layoutSubviews;

@end
