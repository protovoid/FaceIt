//
//  FaceView.swift
//  FaceIt
//
//  Created by Chad on 2/22/17.
//  Copyright © 2017 Chad Williams. All rights reserved.
//

import UIKit

class FaceView: UIView {
  
  var scale: CGFloat = 0.90
  
  var mouthCurvature: Double = 0.0 // 1 full smile, -1 full frown

  
  fileprivate var skullRadius: CGFloat {
    return min(bounds.size.width, bounds.size.height) / 2 * scale
  }
  
  fileprivate var skullCenter: CGPoint {
   return CGPoint(x: bounds.midX, y: bounds.midY)
  }
  
  fileprivate struct Ratios {
    static let SkullRadiusToEyeOffset: CGFloat = 3
    static let SkullRadiusToEyeRadius: CGFloat = 10
    static let SkullRadiusToMouthWidth: CGFloat = 1
    static let SkullRadiusToMouthHeight: CGFloat = 3
    static let SkullRadiusToMouthOffset: CGFloat = 3
  }
  
  fileprivate enum Eye {
    case Left
    case Right
  }
  
  fileprivate func pathForCircleCenteredAtPoint(midPoint: CGPoint, withRadius radius: CGFloat) -> UIBezierPath {
    let path = UIBezierPath(
      arcCenter: midPoint,
      radius: radius,
      startAngle: 0.0,
      endAngle: CGFloat(2*M_PI),
      clockwise: false
    )
    path.lineWidth = 5.0
    return path
  }
  
  fileprivate func getEyeCenter(eye: Eye) -> CGPoint {
    let eyeOffset = skullRadius / Ratios.SkullRadiusToEyeOffset
    var eyeCenter = skullCenter
    eyeCenter.y -= eyeOffset
    switch eye {
    case .Left: eyeCenter.x -= eyeOffset
    case .Right: eyeCenter.x += eyeOffset
    }
    return eyeCenter
  }
  
  fileprivate func pathForEye(eye: Eye) -> UIBezierPath {
    let eyeRadius = skullRadius / Ratios.SkullRadiusToEyeRadius
    let eyeCenter = getEyeCenter(eye: eye)
    return pathForCircleCenteredAtPoint(midPoint: eyeCenter, withRadius: eyeRadius)
  }
  
  fileprivate func pathForMouth() -> UIBezierPath {
    let mouthWidth = skullRadius / Ratios.SkullRadiusToMouthWidth
    let mouthHeight = skullRadius / Ratios.SkullRadiusToMouthHeight
    let mouthOffset = skullRadius / Ratios.SkullRadiusToMouthOffset
    
    let mouthRect = CGRect(x: skullCenter.x - mouthWidth/2, y: skullCenter.y + mouthOffset, width: mouthWidth, height: mouthHeight)
    
    // return UIBezierPath(rect: mouthRect)
    
    let smileOffset = CGFloat(max(-1, min(mouthCurvature, 1))) * mouthRect.height
    let start = CGPoint(x: mouthRect.minX, y: mouthRect.minY)
    let end = CGPoint(x: mouthRect.maxX, y: mouthRect.minY)
    let cp1 = CGPoint(x: mouthRect.minX + mouthRect.width / 3, y: mouthRect.minY + smileOffset)
    let cp2 = CGPoint(x: mouthRect.maxX - mouthRect.width / 3, y: mouthRect.minY + smileOffset)
    
    let path = UIBezierPath()
    path.move(to: start)
    path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
    path.lineWidth = 5.0
    
    return path
  }

 
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
      

      // let skullRadius = min(bounds.size.width, bounds.size.height) / 2
      // let skullCenter = CGPoint(x: bounds.midX, y: bounds.midY)
      
      

      UIColor.blue.set()
      pathForCircleCenteredAtPoint(midPoint: skullCenter, withRadius: skullRadius).stroke()
      pathForEye(eye: .Left).stroke()
      pathForEye(eye: .Right).stroke()
      pathForMouth().stroke()
    }
  
  // t

}
