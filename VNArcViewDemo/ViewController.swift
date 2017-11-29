//
//  ViewController.swift
//  VNArcViewDemo
//
//  Created by Varun Naharia on 29/11/17.
//  Copyright © 2017 Varun Naharia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var arcView: VNArcView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sliderChangeAction(_ sender: UISlider) {
        arcView.setProgressValue(percent: CGFloat(sender.value))
    }
    
}

