//
//  FaceViewController.swift
//  FaceIt
//
//  Created by Chad on 2/22/17.
//  Copyright © 2017 Chad Williams. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {
  
  // MARK: Model
  
  var expression = FacialExpression(eyes: .Open, eyeBrows: .Normal, mouth: .Smile) {
    didSet {
      updateUI() // model changed, so update the View
    }
    
  }
  
  // MARK: View
  
  @IBOutlet weak var faceView: FaceView! {
    didSet {
      /*
       // OLD way (still works with Swift 3.0)
      faceView.addGestureRecognizer(UIPinchGestureRecognizer(
        target: faceView, action: #selector(FaceView.changeScale(_:))
      ))
      let happierSwipeGestureRecognizer = UISwipeGestureRecognizer(
        target: self, action: #selector(FaceViewController.increaseHappiness)
      )
      happierSwipeGestureRecognizer.direction = .up
      faceView.addGestureRecognizer(happierSwipeGestureRecognizer)
      let sadderSwipeGestureRecognizer = UISwipeGestureRecognizer(
        target: self, action: #selector(FaceViewController.decreaseHappiness)
      )
      sadderSwipeGestureRecognizer.direction = .down
      faceView.addGestureRecognizer(sadderSwipeGestureRecognizer)
       updateUI()
      */
      
      let handler = #selector(FaceView.changeScale(byReactingTo:))
      let pinchRecognizer = UIPinchGestureRecognizer(target: faceView, action: handler)
      faceView.addGestureRecognizer(pinchRecognizer)
      let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleEyes(byReactingTo:)))
      tapRecognizer.numberOfTapsRequired = 1
      faceView.addGestureRecognizer(tapRecognizer)
      
      let happierSwipeGestureRecognizer = UISwipeGestureRecognizer(
        target: self, action: #selector(FaceViewController.increaseHappiness))
      happierSwipeGestureRecognizer.direction = .up
      faceView.addGestureRecognizer(happierSwipeGestureRecognizer)
      
      let sadderSwipeGestureRecognizer = UISwipeGestureRecognizer(
        target: self, action: #selector(FaceViewController.decreaseHappiness))
      sadderSwipeGestureRecognizer.direction = .down
      faceView.addGestureRecognizer(sadderSwipeGestureRecognizer)
      
      updateUI()
    }
  }
  
  fileprivate func updateUI() {
      switch expression.eyes {
      case .Open: faceView?.eyesOpen = true
      case .Closed: faceView?.eyesOpen = false
      case .Squinting: faceView?.eyesOpen = false
      }
      faceView?.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0 // default to zero
      faceView?.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
  }
  
  fileprivate var mouthCurvatures = [FacialExpression.Mouth.Frown:-1.0,.Grin:0.5,.Smile:1.0,.Smirk:-0.5,.Neutral:0.0]
  fileprivate var eyeBrowTilts = [FacialExpression.EyeBrows.Relaxed:0.5,.Furrowed:-0.5,.Normal:0.0]
  
    // MARK: Gesture Handlers
  
  func increaseHappiness() {
    expression.mouth = expression.mouth.happierMouth()
  }
  
  func decreaseHappiness() {
    expression.mouth = expression.mouth.sadderMouth()
  }
  
  @IBAction func toggleEyes(byReactingTo tapRecognizer: UITapGestureRecognizer) {
    if tapRecognizer.state == .ended {
      switch expression.eyes {
      case .Open: expression.eyes = .Closed
      case .Closed: expression.eyes = .Open
      case .Squinting: break
      }
    }
  }
  
  func changeBrows(_ recognizer: UIRotationGestureRecognizer) {
    switch recognizer.state {
    case .changed,.ended:
      if recognizer.rotation > CGFloat(Double.pi/4) {
        expression.eyeBrows = expression.eyeBrows.moreRelaxedBrow()
        recognizer.rotation = 0.0
      } else if recognizer.rotation < -CGFloat(Double.pi/4) {
        expression.eyeBrows = expression.eyeBrows.moreFurrowedBrow()
        recognizer.rotation = 0.0
      }
    default:
      break
    }
  }
  

  

  

  

  
  
}

