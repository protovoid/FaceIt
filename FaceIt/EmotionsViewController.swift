//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by Chad on 2/24/17.
//  Copyright © 2017 Chad Williams. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {

       

 
    // MARK: - Navigation
  
  private let emotionalFaces: Dictionary<String,FacialExpression> = [
    "angry" : FacialExpression(eyes: .Closed, eyeBrows: .Furrowed, mouth: .Frown),
    "happy" : FacialExpression(eyes: .Open, eyeBrows: .Normal, mouth: .Smile),
    "worried" : FacialExpression(eyes: .Open, eyeBrows: .Relaxed, mouth: .Smirk),
    "mischievious" : FacialExpression(eyes: .Open, eyeBrows: .Furrowed, mouth: .Grin)
  ]

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      var destinationvc = segue.destination
      // if destination vc is NavController, get controller inside to segue to instead
      if let navcon = destinationvc as? UINavigationController {
        destinationvc = navcon.visibleViewController ?? destinationvc
      }
      if let facevc = destinationvc as? FaceViewController {
        if let identifier = segue.identifier {
          if let expression = emotionalFaces[identifier] {
            facevc.expression = expression
            
            facevc.navigationItem.title = (sender as? UIButton)?.currentTitle
            
         
          }
        }
      }
    
    }
  

}
