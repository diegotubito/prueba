//
//  MLBotonRectangular.swift
//  prueba
//
//  Created by iMac on 01/03/2019.
//  Copyright © 2019 iMac. All rights reserved.
//

import Foundation
import UIKit

class MLBotonRectangular : UIView {
    var layerRectangulo : CAShapeLayer!
    var label : UILabel!
    var text : String = "+ GASTO"
    
    var timer : Timer!
    
    var isEnabled : Bool = true {
        didSet {
            if isEnabled != oldValue {
                cargarParametros()
            }
        }
    }
    
    func cargarParametros() {
        if isEnabled {
            parametros.fillColor = .clear
            parametros.strokeColor = .white
            parametros.textColor = .white
        } else {
            parametros.fillColor = .clear
            parametros.strokeColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
            parametros.textColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        }
        crearBoton()
     }
    
    
    class parametros {
        static var instance = parametros()
        
        static var roundedCorner : CGFloat = 10
        static var textColor : UIColor = .white
        static var lineWidth : CGFloat = 0.5
        static var strokeColor : UIColor = .lightGray
        static var fillColor : UIColor = .clear
        static var movingBarWidth : CGFloat = 3
        static var movingBarColor : UIColor = .white
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        inicializar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
        inicializar()
    }
    
    func inicializar() {
        self.layer.backgroundColor = UIColor.clear.cgColor
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.addGestureRecognizer(tap)
        
        cargarParametros()
        
        crearBoton()
        
        
    }
    
   
    func crearBoton() {
        for i in subviews {
            i.removeFromSuperview()
        }
        self.layer.borderColor = parametros.strokeColor.cgColor
        self.layer.borderWidth = parametros.lineWidth
        self.layer.cornerRadius = parametros.roundedCorner
        crearLayer()
        crearLabel()
        
   
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(crearAnimacion), userInfo: nil, repeats: true)
        
        
    }
    
    @objc func crearAnimacion() {
        let anim1 = animateStroke(from: 0, to: 1, keyPath: "strokeStart", beginTime: 0.05)
        let anim2 = animateStroke(from: 0, to: 1, keyPath: "strokeEnd", beginTime: 0)
    
        let group = CAAnimationGroup()
        group.animations = [anim1, anim2]
        group.speed = 0.6
        group.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        group.repeatCount = 1
        group.isRemovedOnCompletion = true
    
        layerRectangulo.add(group, forKey: nil)
        
        
        
        
    }
    @objc func tapped() {
        
    }
    
    func crearLabel() {
        label = UILabel(frame: CGRect(x: 8, y: 0, width: self.frame.width - 16, height: self.frame.height))
        label.text = text
        label.textColor = parametros.textColor
        label.textAlignment = .center
        self.addSubview(label)
    }
    
    
    func crearLayer() {
        layerRectangulo = CAShapeLayer()
        layerRectangulo.strokeStart = 0
        layerRectangulo.strokeEnd = 0
        layerRectangulo.lineCap = .round
        layerRectangulo.lineWidth = parametros.movingBarWidth
        layerRectangulo.strokeColor = parametros.movingBarColor.cgColor
        layerRectangulo.fillColor = parametros.fillColor.cgColor
        

        layerRectangulo.path = getRectPath()
        /*
        layerRectangulo.shadowColor = SHADOW_COLOR.cgColor
        layerRectangulo.shadowRadius = SHADOW_RADIOUS
        layerRectangulo.shadowOffset = SHADOW_OFFSET
        layerRectangulo.shadowOpacity = SHADOW_OPACITY
        layerRectangulo.shouldRasterize = true
        let scale = true
        layerCirculo.rasterizationScale = scale ? UIScreen.main.scale : 1
        //  layerCirculo.shadowPath = getRectPath()
        */
        //self.backgroundColor = .white
        self.layer.addSublayer(layerRectangulo)
        
        
        
        
        
    }
    
    
    
    func getRectPath() -> CGPath {
        let path = CGMutablePath()
     //   path.addRect(CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        path.addRoundedRect(in: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), cornerWidth: parametros.roundedCorner, cornerHeight: parametros.roundedCorner)
        
        return path
    }
    
   
    func animateStroke(from: CGFloat, to: CGFloat, keyPath: String, beginTime: TimeInterval) -> CABasicAnimation {
        // Create the animation for the shape view
        let animation = CABasicAnimation(keyPath: keyPath)
        animation.fromValue = from
        animation.toValue = to
      //  animation.duration = 2 // seconds
        //  animationCircle.isRemovedOnCompletion = true
        animation.autoreverses = false
        animation.beginTime = beginTime
        //animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        return animation
    }
    
    func animateColor(from: UIColor, to: UIColor) -> CABasicAnimation {
        // Create the animation for the shape view
        let anim = CABasicAnimation(keyPath: "fillColor")
        anim.fromValue = from.cgColor
        anim.toValue = to.cgColor
        anim.duration = 1 // seconds
        anim.repeatCount = 1
        
        return anim
    }
    
    func animateShadowColor(from: UIColor, to: UIColor) -> CABasicAnimation {
        // Create the animation for the shape view
        let anim = CABasicAnimation(keyPath: "shadowColor")
        anim.fromValue = from.cgColor
        anim.toValue = to.cgColor
        anim.duration = 1 // seconds
        anim.repeatCount = 1
        
        return anim
    }
    
    func animateLineWidth(from: CGFloat, to: CGFloat) -> CABasicAnimation {
        // Create the animation for the shape view
        let anchoLinea = CABasicAnimation(keyPath: "lineWidth")
        anchoLinea.fromValue = from
        anchoLinea.toValue = to
        anchoLinea.duration = 1 // seconds
        
        anchoLinea.autoreverses = false
        anchoLinea.repeatCount = 1
        anchoLinea.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        return anchoLinea
    }
    
    func labelAnimation(from: CGFloat, to: CGFloat) -> CABasicAnimation {
        // Animate font size
        
        let animation = CABasicAnimation(keyPath: "transform.scale.x")
        animation.fromValue = from
        animation.toValue = to
        animation.duration = 0.5
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        return animation
    }
}


extension MLBotonRectangular: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let key = anim.value(forKey: "miLabel") as? Int {
            
        }
    }
}
