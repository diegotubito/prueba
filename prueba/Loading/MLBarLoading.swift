//
//  MLBarLoading.swift
//  prueba
//
//  Created by iMac on 20/03/2019.
//  Copyright © 2019 iMac. All rights reserved.
//

import Foundation
import UIKit

class MLBarLoading: UIView {
    var blurEffectView : UIVisualEffectView!
    
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
        
        start()
    }
    
    func start() {
       // startBlurEffect()
        drawBodyArea()
    }
    
    func drawBodyArea() {
        drawOneBar()
    }
    
    func drawOneBar() {
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: 0, y: 0))
        linePath.addLine(to: CGPoint(x: 0, y: bodyArea.frame.height))
        linePath.close()
        
        let barShapeLayer = CAShapeLayer()
        barShapeLayer.fillColor = UIColor.clear.cgColor
        barShapeLayer.strokeColor = UIColor.orange.cgColor
        barShapeLayer.lineWidth = 10
        barShapeLayer.lineCap = .round
        barShapeLayer.lineJoin = .round
        barShapeLayer.path = linePath.cgPath
        bodyArea.layer.addSublayer(barShapeLayer)
        
        animateBar(bar: barShapeLayer)
        
    }
    
    func animateBar(bar: CAShapeLayer) {
        // 1)
        let duration: CFTimeInterval = 2
        
        // 2)
        let end = CABasicAnimation(keyPath: "strokeEnd")
        end.fromValue = 0
        end.toValue = 1.0175
        end.beginTime = 0
        end.duration = duration * 0.75
        end.timingFunction = CAMediaTimingFunction(controlPoints: 0.2, 0.88, 0.09, 0.99)
        end.fillMode = CAMediaTimingFillMode.forwards
        
        // 3)
        let begin = CABasicAnimation(keyPath: "strokeStart")
        begin.fromValue = 0
        begin.toValue = 1.0175
        begin.beginTime = duration * 0.15
        begin.duration = duration * 0.75
        begin.timingFunction = CAMediaTimingFunction(controlPoints: 0.2, 0.88, 0.09, 0.99)
        begin.fillMode = CAMediaTimingFillMode.backwards
        
        // 4)
        let group = CAAnimationGroup()
        group.animations = [end, begin]
        group.duration = duration
        group.repeatCount = Float.infinity
    //    group.autoreverses = true
        
    
        // 6)
        bar.add(group, forKey: "bar-animation")
        
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
            
        }
        //stop animation at 0.5sec
        blurEffectView.pauseAnimation(delay: 0.5)
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
