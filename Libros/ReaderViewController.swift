//
//  ReaderViewController.swift
//  Libros
//
//  Created by Yoshihiro Tanaka on 2017/01/14.
//  Copyright © 2017年 Yoshihiro Tanaka. All rights reserved.
//

import UIKit
import AVFoundation

protocol ReaderViewControllerDelegate {
    func onReadCompleted(_ code: String)
}

class ReaderViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    var delegate: ReaderViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            let captureSession = AVCaptureSession()
            captureSession.addInput(input)
            
            let captureOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureOutput)
            captureOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureOutput.metadataObjectTypes = [AVMetadataObjectTypeEAN13Code]
            
            if let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession) {
                previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
                previewLayer.frame = view.layer.bounds
                view.layer.addSublayer(previewLayer)
            }
            
            captureSession.startRunning()
            
            
        } catch {
            print(error)
            return
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        if metadataObjects == nil || metadataObjects.count == 0 {
            return
        }
        
        let metadata = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadata.type == AVMetadataObjectTypeEAN13Code {
            if let code = metadata.stringValue {
                _ = navigationController?.popViewController(animated: true)
                delegate?.onReadCompleted(code)
            }
        }
    }
}
