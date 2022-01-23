//
//  ViewController.swift
//  sehkaiSwiftExtension
//
//  Created by Matthew Nguyen on 11/03/2015.
//  Copyright (c) 2015 Matthew Nguyen. All rights reserved.
//

import UIKit
import SKSwiftExtension

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.white
        
        let jigglingView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        jigglingView.backgroundColor = UIColor.black
        self.view.addSubview(jigglingView)
        jigglingView.startJiggleAnimation()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleJiggling(_:)))
        jigglingView.addGestureRecognizer(tapGesture)
    }
    
    @objc func toggleJiggling(_ sender: UITapGestureRecognizer) {
        if sender.view?.isJiggling == true {
            sender.view?.stopJiggleAnimation()
        }
        else {
            sender.view?.startJiggleAnimation()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

