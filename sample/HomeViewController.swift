//
//  HomeViewController.swift
//  sample
//
//  Created by user174069 on 6/12/20.
//  Copyright © 2020 user174353. All rights reserved.
//

import UIKit
import AVFoundation

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }//end of viewDidLoad
    
    //function to switch on/off flash light
    func toggleFlash() {
        //Guard let to capture early functions returns
        //AvCapture to access hardware features of the device
        //setting hardware controls/features of the repsective device into 'device'
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        
        //checking whether device has torch or not
        guard device.hasTorch else { return }

        do {
            //to handle and configure hardware controls
            try device.lockForConfiguration()

            //setting button for turning on and off torch
            if (device.torchMode == AVCaptureDevice.TorchMode.on) {
                device.torchMode = AVCaptureDevice.TorchMode.off
            } else {
                do {
                    try device.setTorchModeOn(level: 1.0)
                } catch {
                    print(error)
                }
            }

            //to release the lockForConfiguration
            device.unlockForConfiguration()
        } catch {
            print(error)
        }
    }//end of flashlight
    
    
    @IBAction func clockInOutPressed(_ sender: UIButton) {
        print("clock in out pressed");
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
