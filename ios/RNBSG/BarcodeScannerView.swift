//
//  SwiftView.swift
//  RNBSG
//

import UIKit

class BarcodeScannerView: BarcodeScannerViewObjC {
    let childVC = UIStoryboard(name: "GMVBD", bundle: nil).instantiateInitialViewController() as! BarcodeScannerChildViewController
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        DispatchQueue.main.async {
            if let rootVC = UIApplication.shared.delegate?.window??.rootViewController {
                rootVC.addChildViewController(self.childVC)
                self.childVC.swiftView = self
                self.addSubview(self.childVC.view)
                self.childVC.didMove(toParentViewController: rootVC)
            }
        }

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        childVC.view.frame = bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init coder isn't supported")
    }
    
    var myBarcodeTypes: Int?
    
    var barcodeTypes: Int {
        get {
            return self.myBarcodeTypes ?? -1
        }
        
        set(barcodeTypes) {
            //print("RNBSG", barcodeTypes)
            self.myBarcodeTypes = barcodeTypes
        }
    }
}
