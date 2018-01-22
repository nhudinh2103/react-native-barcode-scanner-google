//
//  BarcodeScannerViewController.swift
//  RNBSG
//
//

/*
 * This file contains Swift rewrites of CameraViewContoller.m and CameraViewController.h from
 * https://github.com/googlesamples/ios-vision/tree/master/BarcodeDetectorDemo .
 *
 * The original files (CameraViewContoller.m and CameraViewController.h) are
 * under copyright of Google Inc. and Apache v2.0 license.
 *
 * That's vary important, polite and formally right to note.
 *
 */

import UIKit

class BarcodeScannerChildViewController: CameraViewController {
    var swiftView: BarcodeScannerView?
    
    //@property(nonatomic, strong) GMVDetector *barcodeDetector;
    var barcodeDetector: GMVDetector?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.session = AVCaptureSession()
        self.session.sessionPreset = AVCaptureSessionPresetMedium
        self.updateCameraSelection()
        
        self.setUpVideoProcessing()
        
        self.setUpCameraPreview()
        
        /*var options: [String: Int]?
        //print("RNBSG2", swiftView?.myBarcodeTypes)
        if let barcodeTypes = swiftView?.maybeBarcodeTypes {
            options = [GMVDetectorBarcodeFormats : barcodeTypes]
        }
        
        self.barcodeDetector = GMVDetector(ofType: GMVDetectorTypeBarcode, options: options)*/
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
        
        
        if let barcodes = self.barcodeDetector?.features(in: image, options: options) as? [GMVBarcodeFeature] {
            //print("Detected \(barcodes.count) barcodes")
            
            for barcode in barcodes {
                //print(barcode.rawValue, barcode.format)
                let data = String(barcode.rawValue) ?? ""
                //let type = barcodeTypesDict[barcode.format.rawValue] ?? "unknown"
                let type = barcode.format.rawValue
                
                if let onBarcodeRead = swiftView?.onBarcodeRead {
                    onBarcodeRead([
                        "data" : data,
                        "type" : type
                    ])
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
