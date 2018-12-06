//
//  VDSCircleAnimation.swift
//  VDS4CircleAnimation
//
//  Created by Vimal Das on 04/12/18.
//  Copyright © 2018 Vimal Das. All rights reserved.
//

import UIKit

class VDSCircleAnimation: UIView {
    
    
    private var size:CGFloat = 0.0
    private var circleCount = 4
    private var circleArray = [UIView]()
    private var translateDuration = 0.2
    
    internal var scale:CGFloat = 5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func setupViews() {
        size = min(self.frame.size.height, self.frame.size.width)/scale
        
        for i in 0 ..< circleCount {
            let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: size, height: size)))
            view.tag = i
            view.layer.cornerRadius = size/2
            view.layer.masksToBounds = true
            self.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.heightAnchor.constraint(equalToConstant: size).isActive = true
            view.widthAnchor.constraint(equalToConstant: size).isActive = true
            circleArray.append(view)
        }
        
        let v1 = circleArray[0]
        v1.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        v1.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        v1.backgroundColor = UIColor(red: 0, green: 253/255, blue: 141/255, alpha: 1)
        
        let v2 = circleArray[1]
        v2.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        v2.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        v2.backgroundColor = UIColor(red: 0, green: 172/255, blue: 246/255, alpha: 1)
        
        
        let v3 = circleArray[2]
        v3.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        v3.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        v3.backgroundColor = UIColor(red: 1, green: 198/255, blue: 0/255, alpha: 1)
        
        
        let v4 = circleArray[3]
        v4.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        v4.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        v4.backgroundColor = UIColor(red: 1, green: 71/255, blue: 141/255, alpha: 1)
        
        animateX()
    }
    
    func animateX() {
        
        let translate = self.size*(self.scale/2 - 1)
        
        let xTranslate = UIViewPropertyAnimator(duration: translateDuration, curve: .easeInOut)
        
        xTranslate.addAnimations {
            let v1 = self.circleArray[0]
            v1.transform = CGAffineTransform(translationX: translate, y: 0)
            let v2 = self.circleArray[1]
            v2.transform = CGAffineTransform(translationX: -translate, y: 0)
        }
        
        xTranslate.addCompletion { (position) in
            let xIdentity = UIViewPropertyAnimator(duration: self.translateDuration, curve: .easeInOut)
            xIdentity.addAnimations {
                let v1 = self.circleArray[0]
                v1.transform = CGAffineTransform.identity
                let v2 = self.circleArray[1]
                v2.transform = CGAffineTransform.identity
            }
            xIdentity.addCompletion({ _ in
                self.animateY()
            })
            xIdentity.startAnimation()
        }
        
        xTranslate.startAnimation()
        
    }
    func animateY() {
        
        let translate = self.size*(self.scale/2 - 1)
        
        let yTranslate = UIViewPropertyAnimator(duration: translateDuration, curve: .easeInOut)
        
        yTranslate.addAnimations {
            let v1 = self.circleArray[2]
            v1.transform = CGAffineTransform(translationX: 0, y: translate)
            let v2 = self.circleArray[3]
            v2.transform = CGAffineTransform(translationX: 0, y: -translate)
        }
        
        yTranslate.addCompletion { (position) in
            let yIdentity = UIViewPropertyAnimator(duration: self.translateDuration, curve: .easeInOut)
            yIdentity.addAnimations {
                let v1 = self.circleArray[2]
                v1.transform = CGAffineTransform.identity
                let v2 = self.circleArray[3]
                v2.transform = CGAffineTransform.identity
            }
            yIdentity.addCompletion({ _ in
                self.animateRotate()
            })
            yIdentity.startAnimation()
        }
        
        yTranslate.startAnimation()
        
    }
    
    func animateRotate() {
        let rotate = UIViewPropertyAnimator(duration: 1, curve: .easeInOut)
        
        rotate.addAnimations {
            for _ in 0..<5 {
                let rotateTransform = CGAffineTransform(rotationAngle: .pi)
                self.transform = self.transform.concatenating(rotateTransform)
            }
        }
        rotate.addCompletion { (_) in
            self.animateX()
        }
        rotate.startAnimation()
    }
    
}
