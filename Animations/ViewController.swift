//
//  ViewController.swift
//  Animations
//
//  Created by Andrew Dhan on 8/29/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import UIKit

extension UIColor {
    static func random() -> UIColor{
        return UIColor(displayP3Red: CGFloat(drand48())/1,
                       green: CGFloat(drand48())/1,
                       blue: CGFloat(drand48())/1,
                       alpha: CGFloat(drand48())/1)
    }
}
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @IBAction func toggle(_ sender: Any) {
        !isScrambled ? scatter() : gather()
        isScrambled = !isScrambled
    }
    
    func scatter() {
        resetOrigins()
        UIView.animate(withDuration: 2) {
            for lambdaLabel in self.lambdaLabelsOnly {
                if let lambdaLabel = lambdaLabel as? UIImageView{
                    lambdaLabel.alpha = 0.0
                }
                
                if let lambdaLabel = lambdaLabel as? UILabel{
                    var frame = lambdaLabel.frame
                    frame.origin.x = self.view.frame.width * CGFloat(drand48())
                    frame.origin.y = 100 + (self.view.frame.height - 100) * CGFloat(drand48())
                    
                    lambdaLabel.frame = frame
                    lambdaLabel.backgroundColor = UIColor.random()
                    lambdaLabel.textColor = UIColor.random()
                    lambdaLabel.transform = CGAffineTransform(rotationAngle: CGFloat(drand48()*360.0))
                }
            }
        }
    }
    
    func gather() {
        UIView.animate(withDuration: 2) {
            for (lambdaLabel, origin) in self.lambdaLabels {
                if let lambdaLabel = lambdaLabel as? UIImageView{
                    lambdaLabel.alpha = 1.0
                }
                if let lambdaLabel = lambdaLabel as? UILabel{
                    var frame = lambdaLabel.frame
                    frame.origin = origin
                    
                    lambdaLabel.backgroundColor = UIColor.white
                    lambdaLabel.textColor = UIColor.black
                    lambdaLabel.transform = CGAffineTransform(rotationAngle: 0.0)
                    lambdaLabel.frame = frame
                    
                }
            }
        }
    }
    func resetOrigins(){
        for lambdaLabel in lambdaLabelsOnly {
            lambdaLabels.append((lambdaLabel, lambdaLabel.frame.origin))
        }
    }
    func animate(){
        for (lambdaLabel, _) in lambdaLabels {
            //
            
            if let lambdaLabel = lambdaLabel as? UIImageView {
                let fadeAnimation = CAKeyframeAnimation(keyPath: "opacity")
                fadeAnimation.values = [1.0, 0.0, 0.0, 1.0]
                fadeAnimation.duration = 3
                lambdaLabel.layer.add(fadeAnimation, forKey: "fade")
                
            } else {
                //Position
                let positionAnimation = CAKeyframeAnimation(keyPath: "position")
                let origin = lambdaLabel.frame.origin
                
                let x = view.frame.width * CGFloat(drand48())
                let y = (view.frame.height - 100) * CGFloat(drand48())
                let endPoint = CGPoint(x: x, y: 100 + y)
                
                positionAnimation.values = [origin, endPoint, endPoint, origin]
                positionAnimation.duration = 3
                // background
                let textColorAnimation = CAKeyframeAnimation(keyPath: "contents")
                
                
                //                textColorAnimation.values
                lambdaLabel.layer.add(positionAnimation, forKey: "scatter")
            }
        }
    }
    
    func setup(){
        let characters = ["L", "A", "M", "B", "D", "A"]
        for index in 0...6 {
            
            
            if index < 6 {
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = false
                label.text = characters[index]
                view.addSubview(label)
                lambdaLabelsOnly.append(label)
            } else {
                let imageView = UIImageView()
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.image = UIImage(named: "LambdaLogo")
                view.addSubview(imageView)
                lambdaLabelsOnly.append(imageView)
                
            }
            let lambdaLabel = lambdaLabelsOnly[index]
            //set horizontal constraints depending on which letter it is
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
                                                           toItem: lambdaLabelsOnly[index - 1],
                                                           attribute: .right,
                                                           multiplier: 1.0,
                                                           constant: 2.0)
            }
            //set vertical constraints for all
            let verticalConstraints = NSLayoutConstraint(item: lambdaLabel,
                                                         attribute: .centerY,
                                                         relatedBy: .equal,
                                                         toItem: view,
                                                         attribute: .centerY,
                                                         multiplier: 1.0,
                                                         constant: 0)
            //set wideth and height constraint for all
            let widthConstraint = NSLayoutConstraint(item: lambdaLabel,
                                                     attribute: .width,
                                                     relatedBy: .equal,
                                                     toItem: nil,
                                                     attribute: .notAnAttribute,
                                                     multiplier: 1.0,
                                                     constant: 20)
            let heightConstraint = NSLayoutConstraint(item: lambdaLabel,
                                                     attribute: .height,
                                                     relatedBy: .equal,
                                                     toItem: nil,
                                                     attribute: .notAnAttribute,
                                                     multiplier: 1.0,
                                                     constant: 50)
            NSLayoutConstraint.activate([verticalConstraints,
                                         horizontalConstraints,
                                         widthConstraint,
                                         heightConstraint])
        }
    }
    
    
    var isScrambled = false
    var lambdaLabelsOnly = [UIView]()
    var lambdaLabels = [(UIView, CGPoint)]()
}

