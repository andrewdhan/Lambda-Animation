//
//  ViewController.swift
//  Animations
//
//  Created by Andrew Dhan on 8/29/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @IBAction func toggle(_ sender: Any) {
        isScrambled = !isScrambled
        animate()
        
    }
    
    func animate(){
        for lambdaLabel in lambdaLabels {
            let animation: CAKeyframeAnimation
            if let lambdaLabel = lambdaLabel as? UIImageView {
                animation = CAKeyframeAnimation(keyPath: "opacity")
                animation.values = [1.0, 0.0, 0.0, 1.0]
                animation.duration = 3
            } else {
                animation = CAKeyframeAnimation(keyPath: "position")
                let origin = lambdaLabel.frame.origin
                
                let x = view.frame.width * CGFloat(drand48())
                let y = view.frame.height * CGFloat(drand48())
                let endPoint = CGPoint(x: x, y: y)
                
                animation.values = [origin, endPoint, endPoint, origin]
                animation.duration = 3
            }
            lambdaLabel.layer.add(animation, forKey: "Scatter!")
        }
    }
    
    func setup(){
        let characters = ["L", "A", "M", "B", "D", "A"]
        
        for index in 0...6 {
            if index < 6 {
                let newLabel = UILabel()
                newLabel.translatesAutoresizingMaskIntoConstraints = false
                newLabel.text = characters[index]
                view.addSubview(newLabel)
                lambdaLabels.append(newLabel)
            } else {
                let newImageView = UIImageView()
                newImageView.translatesAutoresizingMaskIntoConstraints = false
                newImageView.image = UIImage(named: "LambdaLogo")
                view.addSubview(newImageView)
                lambdaLabels.append(newImageView)
                
                let topConstraint = NSLayoutConstraint(item: newImageView,
                                                       attribute: .top,
                                                       relatedBy: .equal,
                                                       toItem: lambdaLabels[5],
                                                       attribute: .top,
                                                       multiplier: 1.0, constant: 0.0)
                let bottomConstraint = NSLayoutConstraint(item: newImageView,
                                                          attribute: .bottom,
                                                          relatedBy: .equal,
                                                          toItem: lambdaLabels[5],
                                                          attribute: .bottom,
                                                          multiplier: 1.0, constant: 0.0)
                
                NSLayoutConstraint.activate([topConstraint,bottomConstraint])
                
            }
            let lambdaLabel = lambdaLabels[index]
            let verticalConstraints = NSLayoutConstraint(item: lambdaLabel,
                                                         attribute: .centerY,
                                                         relatedBy: .equal,
                                                         toItem: view,
                                                         attribute: .centerY,
                                                         multiplier: 1.0,
                                                         constant: 0)
            let horizontalConstraints: NSLayoutConstraint
            if index == 0{
                horizontalConstraints = NSLayoutConstraint(item: lambdaLabel,
                                                           attribute: .left,
                                                           relatedBy: .equal,
                                                           toItem: view,
                                                           attribute: .left,
                                                           multiplier: 1.0,
                                                           constant: 100)
            } else {
                horizontalConstraints = NSLayoutConstraint(item: lambdaLabel,
                                                           attribute: .left,
                                                           relatedBy: .equal,
                                                           toItem: lambdaLabels[index - 1],
                                                           attribute: .right,
                                                           multiplier: 1.0,
                                                           constant: 2.0)
            }
            
            NSLayoutConstraint.activate([verticalConstraints, horizontalConstraints] )
        }
        
    }
    
    
    var isScrambled = false
    var lambdaLabels = [UIView]()
}

