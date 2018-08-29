//
//  ViewController.swift
//  Lambda Animations
//
//  Created by Jonathan T. Miles on 8/29/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func toggle(_ sender: Any) {
        
        let letterArray: [UILabel] = [letterL, letterA1, letterM, letterB, letterD, letterA2]
        
        var letterLocations: [CGPoint] = []
        
        if shouldScramble == true {
            CATransaction.begin()
            let logoFade = CAKeyframeAnimation(keyPath: "opacity")
            logoFade.values = [1.0, 0.75, 0.5, 0.25, 0.0]
            logoFade.duration = 2.0
            lambdaLogo.layer.add(logoFade, forKey: "fadingLogoAnimation")
            CATransaction.setCompletionBlock {
                self.lambdaLogo.layer.opacity = 0.0
            }
            CATransaction.commit()
            
            
            let letterRandomScatter = CAKeyframeAnimation(keyPath: "position")
            
            for letter in letterArray {
                CATransaction.begin()
                // let originalX = letter.frame.origin.x
                // let originalY = letter.frame.origin.y
                
                let x = CGFloat(arc4random_uniform(200))
                let y = CGFloat(arc4random_uniform(200))
                
                let startpoint = letter.center // CGPoint(x: originalX, y: originalY)
                letterLocations.append(startpoint)
                
                let endpoint = CGPoint(x: startpoint.x + x, y: startpoint.y + y)
                
                let values = [startpoint, endpoint]
                letterRandomScatter.values = values
                letterRandomScatter.duration = 3.0
                // letterRandomScatter.transform = CGAffineTransform(rotationAngle: random_angle)
                letter.layer.add(letterRandomScatter, forKey: "Letter scatter animation for \(letter)")
                CATransaction.setCompletionBlock {
                    letter.layer.position = endpoint
                }
                CATransaction.commit()
            }
            
            shouldScramble = false
            
        } else if shouldScramble == false {
            
            CATransaction.begin()
            let logoFadeIn = CAKeyframeAnimation(keyPath: "opacity")
            logoFadeIn.values = [0.0, 0.25, 0.5, 0.75, 1.0]
            logoFadeIn.duration = 2.0
            lambdaLogo.layer.add(logoFadeIn, forKey: "fadingLogoAnimation")
            CATransaction.setCompletionBlock {
                self.lambdaLogo.layer.opacity = 1.0
            }
            CATransaction.commit()
            
            let letterReturn = CAKeyframeAnimation(keyPath: "position")
            
            for letter in letterArray {
                CATransaction.begin()
                let originalX = letter.frame.origin.x
                let originalY = letter.frame.origin.y
                
                let x = CGFloat(arc4random_uniform(200))
                let y = CGFloat(arc4random_uniform(200))
                
                let trajectoryX = (originalX + x)
                let trajectoryY = (originalY + y)
                
                let startpoint = CGPoint(x: originalX, y: originalY)
                let endpoint = CGPoint(x: x, y: y)
                
                let values = [startpoint,
                              CGPoint(x: trajectoryX * 0.25, y: trajectoryY * 0.25),
                              CGPoint(x: trajectoryX * 0.5, y: trajectoryY * 0.5),
                              CGPoint(x: trajectoryX * 0.75, y: trajectoryY * 0.75),
                              endpoint]
                letterReturn.values = values
                letterReturn.duration = 3.0
                letter.layer.add(letterReturn, forKey: "Letter scatter animation for \(letter)")
                CATransaction.setCompletionBlock {
                    letter.layer.position = endpoint
                }
                CATransaction.commit()
            }
            
            shouldScramble = true
        }
        
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var letterL: UILabel!
    @IBOutlet weak var letterA1: UILabel!
    @IBOutlet weak var letterM: UILabel!
    @IBOutlet weak var letterB: UILabel!
    @IBOutlet weak var letterD: UILabel!
    @IBOutlet weak var letterA2: UILabel!
    
    @IBOutlet weak var lambdaLogo: UIImageView!
    
    var shouldScramble: Bool = true
}

