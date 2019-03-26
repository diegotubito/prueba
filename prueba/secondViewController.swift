//
//  secondViewController.swift
//  prueba
//
//  Created by David Diego Gomez on 25/3/19.
//  Copyright © 2019 iMac. All rights reserved.
//

import Foundation
import UIKit

class secondViewController: UIViewController, UIViewControllerTransitioningDelegate {
    override func viewDidLoad() {
        
    }
    
    @IBAction func close(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
 }
