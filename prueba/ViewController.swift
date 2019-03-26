//
//  ViewController.swift
//  prueba
//
//  Created by iMac on 27/02/2019.
//  Copyright © 2019 iMac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let transition = popAnimator()

    @IBOutlet weak var botonCircular: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    //    addBoton()
     //   addBinaryAnim()
    //    addStar()
        transition.dismissCompletion = {
          //  self.selectedImage!.isHidden = false
        }
     }
    
    @IBAction func tapped(_ sender: Any) {
        //present details view controller
        let herbDetails = storyboard!.instantiateViewController(withIdentifier: "secondViewController") as! secondViewController
        herbDetails.transitioningDelegate = self
        present(herbDetails, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
      
    }
    
    func addStar() {
        let aux = MLStarAnimation(frame: CGRect(x: view.frame.width/2, y: view.frame.height/2, width: 100, height: 100))
        self.view.addSubview(aux)
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


extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
       
        transition.presenting = true
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
}
