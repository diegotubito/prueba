//
//  MLCloudPath.swift
//  prueba
//
//  Created by iMac on 12/03/2019.
//  Copyright © 2019 iMac. All rights reserved.
//

import Foundation
import UIKit

func cloudPath(w: CGFloat, h: CGFloat) -> CGMutablePath {
    
    let point_1 = CGPoint(x: w*0.15, y: h*0.35)
    let point_2 = CGPoint(x: w*0.15, y: h*0.95)
    let point_3 = CGPoint(x: w*0.85, y: h*0.95)
    let point_4 = CGPoint(x: w*0.85, y: h*0.20)

    let myPath = CGMutablePath()
    myPath.move(to: point_1)
    myPath.addQuadCurve(to: point_2, control: CGPoint(x: 0, y: 0.7*h))
    myPath.addQuadCurve(to: point_3, control: CGPoint(x: 0.5*w, y: h))
    myPath.addQuadCurve(to: point_4, control: CGPoint(x: w, y: h/2))
    myPath.closeSubpath()
    
    return myPath
}
