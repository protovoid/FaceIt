//
//  FaceViewController.swift
//  FaceIt
//
//  Created by Chad on 2/22/17.
//  Copyright © 2017 Chad Williams. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {
  var expression = FacialExpression(eyes: .Open, eyeBrows: .Normal, mouth: .Smile) {
    didSet {
      updateUI()
    }
    
  }
  
  @IBOutlet weak var faceView: FaceView! { didSet { updateUI() } }
  
  fileprivate var mouthCurvatures = [FacialExpression.Mouth.Frown:-1.0,.Grin:0.5,.Smile:1.0,.Smirk:-0.5,.Neutral:0.0]
  fileprivate var eyeBrowTilts = [FacialExpression.EyeBrows.Relaxed:0.5,.Furrowed:-0.5,.Normal:0.0]
  
  fileprivate func updateUI() {
    switch expression.eyes {
    case .Open: faceView.eyesOpen = true
    case .Closed: faceView.eyesOpen = false
    case .Squinting: faceView.eyesOpen = false
    }
    faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0 // default to zero
    faceView.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
    
  }
  
  
}

