//
//  BarcodeScannerViewController.swift
//  RNBSG
//


import UIKit

class BarcodeScannerViewController: CameraViewController {
    var swiftView: SwiftView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        //super.captureOutput(captureOutput, didOutputSampleBuffer: sampleBuffer, from: connection)
        
        let image: UIImage = GMVUtility.sampleBufferTo32RGBA(sampleBuffer)
        let devicePosition: AVCaptureDevicePosition = AVCaptureDevicePosition.back
        
        let deviceOrientation: UIDeviceOrientation = UIDevice.current.orientation
        let orientation: GMVImageOrientation = GMVUtility.imageOrientation(from: deviceOrientation, with: devicePosition, defaultDeviceOrientation: self.lastKnownDeviceOrientation)
        let options: [ String: NSInteger ] = [ GMVDetectorImageOrientation: orientation.rawValue ]
        
        
        if let barcodes = self.barcodeDetector.features(in: image, options: options) as? [GMVBarcodeFeature] {
            print("Detected \(barcodes.count) barcodes")
            
            for barcode in barcodes {
                print(barcode.rawValue, barcode.format)
                
                if let onBarcodeRead = swiftView?.onBarcodeRead {
                    onBarcodeRead([:])
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
