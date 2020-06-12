//
//  HomeViewController.swift
//  sample
//
//  Created by user174069 on 6/12/20.
//  Copyright © 2020 user174353. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }//end of viewDidLoad
    
    func toggleFlash() {
//        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
//        guard device.hasTorch else { return }
//
//        do {
//            try device.lockForConfiguration()
//
//            if (device.torchMode == AVCaptureDevice.TorchMode.on) {
//                device.torchMode = AVCaptureDevice.TorchMode.off
//            } else {
//                do {
//                    try device.setTorchModeOn(level: 1.0)
//                } catch {
//                    print(error)
//                }
//            }
//
//            device.unlockForConfiguration()
//        } catch {
//            print(error)
//        }
        print("flash light not working")
    }//end of flashlight
    
    
    @IBAction func clockInOutPressed(_ sender: UIButton) {
        print("clock in out pressed")
    }
    
    @IBAction func schedulePressed(_ sender: UIButton) {
        print("schedule pressed")
    }
    
    @IBAction func flashlightPressed(_ sender: UIButton) {
        print("Flashlight pressed");
        toggleFlash();
    }
    
    @IBAction func panicPressed(_ sender: UIButton) {
        print("panic pressed")
    }
}
