//
//  MLBarLoading.swift
//  prueba
//
//  Created by iMac on 20/03/2019.
//  Copyright © 2019 iMac. All rights reserved.
//

import Foundation
import UIKit

protocol MLBarLoadingDelegate {
    func cancelPressedDelegate()
}

class MLBarLoading: UIView {
    var delegate : MLBarLoadingDelegate?
    
    var blurEffectView : UIVisualEffectView!
    
    @IBOutlet var outletCancelar: UIButton!
    @IBOutlet var label: UILabel!
    @IBOutlet var myView: UIView!
    @IBOutlet weak var borderArea: UIView!
    @IBOutlet weak var bodyArea: UIView!
    override init(frame: CGRect) {
        super .init(frame: frame)
        inicializar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
        inicializar()
    }
    
    func inicializar() {
        Bundle.main.loadNibNamed("MLBarLoading", owner: self, options: nil)
        
        let contentFrame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        myView.frame = contentFrame
        addSubview(myView)
        
    }
    
    func hideLoading(message: String) {
        label.text = message
        outletCancelar.isHidden = true
        animateLabel()
        self.alpha = 1
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0
        }) { (termino) in
            self.removeFromSuperview()
        }
 
    }
    
    func animateLabel() {
        let scale = CABasicAnimation(keyPath: "transform.scale")
        scale.fromValue = 1
        scale.toValue = 3
        
        let move = CABasicAnimation(keyPath: "position.y")
        move.fromValue = label.frame.origin.y
        move.toValue = label.frame.origin.y - 50
        
   
        let group = CAAnimationGroup()
        group.duration = 0.5
        group.isRemovedOnCompletion = true
        group.animations = [scale, move]
        
        label.layer.add(group, forKey: nil)
        
    }
    
    
    @IBAction func cancelPressed(_ sender: Any) {
        hideLoading(message: "Acción cancelada")
        delegate?.cancelPressedDelegate()
    }
    
    func showLoading() {
        startBlurEffect()
        
        drawBodyArea()
        
    }
    
    func drawBodyArea() {
        //first bar
        let numberOfBars = 6
        let spaceBetweenBars : CGFloat = 20
        let barWidth : CGFloat = 10
        let barHeight = bodyArea.frame.height/16
        let duration : CFTimeInterval = 0.5
        let elapsedTime : Double = Double(duration) / Double(numberOfBars - 1)
        
        let totalLengthOfBars = (CGFloat(numberOfBars) * barWidth) + (CGFloat(numberOfBars - 1) * spaceBetweenBars)
        let xPosition = (bodyArea.frame.width - totalLengthOfBars)/2 + totalLengthOfBars/5
     
        for i in 1...numberOfBars {
            let bar = drawOneBar(x: xPosition + (CGFloat(i) * spaceBetweenBars), y: 0, width: barWidth, height: barHeight, color: UIColor.orange)
            bodyArea.layer.addSublayer(bar)
            
            let barAnimation = animateBar(duration: duration, beginTime: elapsedTime * Double(i))
            bar.add(barAnimation, forKey: "bar-animation")
            
        }
        
        
    }
    
    func drawOneBar(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, color: UIColor) -> CAShapeLayer {
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: x, y: y))
        linePath.addLine(to: CGPoint(x: x, y: height))
        linePath.close()
        
        let barShapeLayer = CAShapeLayer()
        barShapeLayer.fillColor = UIColor.clear.cgColor
        barShapeLayer.strokeColor = color.cgColor
        barShapeLayer.lineWidth = width
        barShapeLayer.lineCap = .round
        barShapeLayer.lineJoin = .round
        barShapeLayer.path = linePath.cgPath
        
        return barShapeLayer
        
    }
    
    func animateBar(duration: CFTimeInterval, beginTime: CFTimeInterval) -> CASpringAnimation {
        
        let end = CASpringAnimation(keyPath: "transform.scale.y")
        end.fromValue = 0.5
        end.toValue = 3.5
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
    
    
    func createShape() -> CAShapeLayer {
        let shape = CAShapeLayer()
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeColor = UIColor.white.cgColor
        
        
        return shape
    }
    
    func startBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.effect = nil
        blurEffectView.frame = borderArea.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        borderArea.addSubview(blurEffectView)
        
        //start blurring
        UIView.animate(withDuration: 3) {
            self.blurEffectView.effect = UIBlurEffect(style: .light)
            //stop animation at 0.5sec
            self.blurEffectView.pauseAnimation(delay: 0.6)
            
        }
     }
    
    
}

extension UIView {
    public func pauseAnimation(delay: Double) {
        let time = delay + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, time, 0, 0, 0, { timer in
            let layer = self.layer
            let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
            layer.speed = 0.0
            layer.timeOffset = pausedTime
        })
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
    }
    
    public func resumeAnimation() {
        let pausedTime  = layer.timeOffset
        
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
    }
}
