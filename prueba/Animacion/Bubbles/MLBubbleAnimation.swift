//
//  MLBubbleAnimation.swift
//  prueba
//
//  Created by iMac on 07/03/2019.
//  Copyright © 2019 iMac. All rights reserved.
//

import Foundation
import UIKit

class MLFloatingBinaryCode: UIView {
    override init(frame: CGRect) {
        super .init(frame: frame)
        inicializar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
        inicializar()
    }
    
    func inicializar() {
        
        let timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(crear), userInfo: nil, repeats: true)
        
       
        createCloudShape()
    }
    
    func createCloudShape() {
        let shape = CAShapeLayer()
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeColor = UIColor.white.cgColor
        shape.path = cloudPath(w: self.frame.width, h: self.frame.height)
        self.layer.addSublayer(shape)
    }
    
    @objc func crear() {
        
        for _ in 0...6 {
            let label = createLabel()
            label.layer.add(createAnimationPath(), forKey: "grupo")
            addSubview(label)
        }
        
    }
    
    func createLabel() -> UILabel {
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        let number = Int.random(in: 0 ..< 2)
        let randomGray = CGFloat.random(in: 0.5 ..< 1)
        label.text = String(number)
        label.textColor = UIColor.init(red: randomGray, green: randomGray, blue: randomGray, alpha: 1)
        label.textAlignment = .center
        
        return label
    }
    
    func createAnimationPath() -> CAAnimationGroup {
        let wayPath = CGMutablePath()
        let startingX = CGFloat.random(in: 0 ..< frame.width)
        let endingX = CGFloat.random(in: 0 ..< frame.width)
        
        wayPath.move(to: CGPoint(x: startingX, y: 0))
        wayPath.addCurve(to: CGPoint(x: frame.width/2, y: frame.height),
                         control1: CGPoint(x: 0, y: frame.height/4),
                         control2: CGPoint(x: frame.width, y: frame.height/2))
         
        let animationPath = CAKeyframeAnimation(keyPath: #keyPath(CALayer.position))
        animationPath.path = wayPath
    
        let animationFade = CABasicAnimation(keyPath: "opacity")
        
        animationFade.fromValue = 1
        animationFade.toValue = 0
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [animationPath, animationFade]
        groupAnimation.fillMode = CAMediaTimingFillMode.forwards
        groupAnimation.isRemovedOnCompletion = false
        
        groupAnimation.duration = 1
        groupAnimation.repeatCount = 1
      
        
        return groupAnimation
        
    }
    
    
    
    
    
}
