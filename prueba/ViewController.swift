//
//  ViewController.swift
//  prueba
//
//  Created by iMac on 27/02/2019.
//  Copyright © 2019 iMac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var botonCircular: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addBoton()
        
        addBinaryAnim()
    }

    func addBinaryAnim() {
        let aux = MLFloatingBinaryCode(frame: CGRect(x: 0, y: view.safeAreaInsets.top + 30, width: view.frame.width, height: 100))
        view.addSubview(aux)
    }
    
    func addBoton() {
        let aux = MLSwitchCircular(frame: CGRect(x: 0, y: 0, width: botonCircular.frame.width, height: botonCircular.frame.height))
         botonCircular.addSubview(aux)
    }
}

