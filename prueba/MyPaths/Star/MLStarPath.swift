//
//  starPath.swift
//  prueba
//
//  Created by iMac on 18/03/2019.
//  Copyright © 2019 iMac. All rights reserved.
//

import Foundation
import UIKit

class MLStarAnimation: UIView {
    override init(frame: CGRect) {
        super .init(frame: frame)
        drawStar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
        
        drawStar()
        
        let transformLayer = CATransformLayer()
        var perspective = CATransform3DIdentity
        perspective.m34 = -1 / 500
        transformLayer.transform = perspective
        
        transformLayer.position = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        
        transformLayer.addSublayer(self.layer)
        self.layer.addSublayer(transformLayer)
        
        self.layer.transform = CATransform3DMakeRotation(-0.5, 1, 0, 0)
    }
    
    func drawStar() {
        let path = starPath(w: self.frame.width, h: self.frame.height)
        let shape = createShape()
        shape.path = path
        self.layer.addSublayer(shape)
    }
    
    func starPath(w: CGFloat, h: CGFloat) -> CGMutablePath {
        
        let point_1 = CGPoint(x: w/2, y: 0)
        let point_2 = CGPoint(x: 2*w/3, y: 3*h/8)
        let point_3 = CGPoint(x: w, y: h/2)
        let point_4 = CGPoint(x: 2*w/3, y: h*5/8)
        let point_5 = CGPoint(x: w/2, y: h)
        let point_6 = CGPoint(x: w/3, y: 5*h/8)
        let point_7 = CGPoint(x: 0, y: h/2)
        let point_8 = CGPoint(x: w/3, y: 3*h/8)
        
        let myPath = CGMutablePath()
        myPath.move(to: point_1)
        myPath.addLine(to: point_2)
        myPath.addLine(to: point_3)
        myPath.addLine(to: point_4)
        myPath.addLine(to: point_5)
        myPath.addLine(to: point_6)
        myPath.addLine(to: point_7)
        myPath.addLine(to: point_8)
        myPath.closeSubpath()
        
        return myPath
    }

    func createShape() -> CAShapeLayer {
        let shape = CAShapeLayer()
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeColor = UIColor.white.cgColor

        return shape
    }

}
