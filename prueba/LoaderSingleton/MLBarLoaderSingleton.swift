//
//  MLBarLoaderSingleton.swift
//  prueba
//
//  Created by David Diego Gomez on 21/3/19.
//  Copyright © 2019 iMac. All rights reserved.
//

import Foundation
import UIKit

class MLBarLoaderSingleton {
    var instance = MLBarLoaderSingleton()
    
    //user parameters
    public static var color : UIColor = UIColor.lightGray
    public static var numberOfBars : Int = 2
    public static var spaceBetweenBars : CGFloat = 25
    
    //private parameters
    private static var ancho : CGFloat!
    private static var alto : CGFloat!
    private static var borderArea : UIView!
    private static var bodyArea : UIView!
    private static var loadingMessage : String = "Desacarga"
    
    static var viewController : UIViewController!
    
    
    static func showLoading(controller: UIViewController, message: String) {
        if viewController != nil {
            removeAllViews()
        }
        viewController = controller
        loadingMessage = message
        
        ancho = viewController?.view.frame.width
        alto = viewController?.view.frame.height
        
        borderAreaInit()
        bodyAreaInit()
        
        drawBodyArea()
        
     }
    
    static func hideLoading() {
        removeAllViews()
    }
}

//drawing
extension MLBarLoaderSingleton {
    
    fileprivate static func removeAllViews() {
        borderArea.removeFromSuperview()
        bodyArea.removeFromSuperview()
        
    }
    
    fileprivate static func drawBodyArea() {
        //first bar
        let barWidth : CGFloat = 7
        let barHeight = bodyArea.frame.height/16
        let duration : CFTimeInterval = 0.5
        let elapsedTime : Double = Double(duration) / Double(numberOfBars - 1)
        
        let totalLengthOfBars = (CGFloat(numberOfBars) * barWidth) + (CGFloat(numberOfBars - 1) * spaceBetweenBars)
        let xPosition = (bodyArea.frame.width - totalLengthOfBars)/2
        //para que quede centrado, es una compensacion. con la linea anterior deberia ser suficiente si no usara lineWidth
        let compensacionPorAnchoDeBarras = (CGFloat(numberOfBars)*barWidth)/2
        
        for i in 0...numberOfBars - 1{
            let bar = drawOneBar(x: compensacionPorAnchoDeBarras + xPosition + (CGFloat(i) * spaceBetweenBars), y: 0, width: barWidth, height: barHeight, color: color)
            bodyArea.layer.addSublayer(bar)
            
            let barAnimation = animateBar(duration: duration, beginTime: elapsedTime * Double(i))
            bar.add(barAnimation, forKey: "bar-animation")
            
        }
        
        drawLabel()
    }
    
    fileprivate static func drawLabel() {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: ancho, height: alto))
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = loadingMessage
        bodyArea.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        let c1 = NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: bodyArea, attribute: .centerX, multiplier: 1, constant: 0)
        let c2 = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: bodyArea, attribute: .centerY, multiplier: 1, constant: 10)
        viewController.view.addConstraints([c1,c2])
        
    }
    
    fileprivate static func drawOneBar(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, color: UIColor) -> CAShapeLayer {
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: x, y: y))
        linePath.addLine(to: CGPoint(x: x, y: height))
        linePath.close()
        
        let barShapeLayer = CAShapeLayer()
        barShapeLayer.fillColor = UIColor.clear.cgColor
        barShapeLayer.strokeColor = color.cgColor
        barShapeLayer.lineWidth = width
        //  barShapeLayer.lineCap = .round
        barShapeLayer.lineJoin = .round
        barShapeLayer.path = linePath.cgPath
        
        return barShapeLayer
        
    }
}

//some animations
extension MLBarLoaderSingleton {
    fileprivate static func animateBar(duration: CFTimeInterval, beginTime: CFTimeInterval) -> CASpringAnimation {
        
        let end = CASpringAnimation(keyPath: "transform.scale.y")
        end.fromValue = 0.5
        end.toValue = 4
        end.damping = 30
        
        end.mass = 1
        end.stiffness = 100
        //  end.timingFunction = CAMediaTimingFunction(controlPoints: 0.2, 0.8, 0.9, 1.0)
        
        end.duration = duration
        end.beginTime = beginTime
        end.repeatCount = Float.infinity
        end.isRemovedOnCompletion = true
        end.autoreverses = true
        return end
        
    }
}

//some init views
extension MLBarLoaderSingleton {
    fileprivate static func borderAreaInit() {
        borderArea = UIView(frame: CGRect(x: 0, y: 0, width: ancho, height: alto))
        borderArea.layer.backgroundColor = UIColor.black.cgColor
        borderArea.alpha = 0.8
        viewController?.view.addSubview(borderArea)
        
    }
    
    fileprivate static func bodyAreaInit() {
        bodyArea = UIView(frame: CGRect(x: 0, y: alto/2 - 50, width: ancho, height: 100))
        bodyArea.layer.backgroundColor = UIColor.clear.cgColor
        viewController?.view.addSubview(bodyArea)
    }
}

