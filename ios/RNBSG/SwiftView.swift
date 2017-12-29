//
//  SwiftView.swift
//  RNBSG
//

import UIKit

class SwiftView: UIView {
    let childVC = UIStoryboard(name: "GMVBD", bundle: nil).instantiateInitialViewController() as! CameraViewController
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if let rootVC = UIApplication.shared.delegate?.window??.rootViewController {
            rootVC.addChildViewController(childVC)
            addSubview(childVC.view)
            childVC.didMove(toParentViewController: rootVC)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        childVC.view.frame = bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init coder isn't supported")
    }
}
