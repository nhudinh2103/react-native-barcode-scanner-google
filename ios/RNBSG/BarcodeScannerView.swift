//
//  SwiftView.swift
//  RNBSG
//

import UIKit

class BarcodeScannerView: BarcodeScannerViewObjC {
    let childVC = UIStoryboard(name: "GMVBD", bundle: nil).instantiateInitialViewController() as! BarcodeScannerChildViewController
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if let rootVC = UIApplication.shared.delegate?.window??.rootViewController {
            rootVC.addChildViewController(self.childVC)
            self.childVC.swiftView = self
            self.addSubview(self.childVC.view)
            self.childVC.didMove(toParentViewController: rootVC)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        childVC.view.frame = bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init coder isn't supported")
    }
    
    var options: [String: Int]?
    var barcodeTypes: Int {
        get {
            return options?[GMVDetectorBarcodeFormats] ?? -1
        }
        
        set(barcodeTypes) {
            //print("RNBSG setting barcode types")
            
            if barcodeTypes != -1 {
                options = [GMVDetectorBarcodeFormats : barcodeTypes]
            }
            
            childVC.barcodeDetector = GMVDetector(ofType: GMVDetectorTypeBarcode, options: options)
        }
    }
}
