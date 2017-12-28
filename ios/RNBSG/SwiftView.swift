//
//  SwiftView.swift
//  RNBSG
//

import UIKit

class SwiftView: UIView {
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
    let childVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! CameraViewController
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if let rootVC = UIApplication.shared.delegate?.window??.rootViewController {
            rootVC.addChildViewController(childVC)
            addSubview(childVC.view)
            autoresizesSubviews = false
            childVC.didMove(toParentViewController: rootVC)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init coder isn't supported")
    }
}
