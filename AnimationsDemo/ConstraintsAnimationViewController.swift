//
//  ConstraintsAnimationViewController.swift
//  AnimationsDemo
//
//  Created by Lubos Ilcik on 29/11/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit

class ConstraintsAnimationViewController: UIViewController {

    @IBOutlet weak var messageBackground: UIImageView!
    @IBOutlet weak var signUpButton: UIButton!

    @IBOutlet weak var welcomeCenterX: NSLayoutConstraint!
    @IBOutlet weak var signUpCenterX: NSLayoutConstraint!
    @IBOutlet weak var messageBackgroundCenterX: NSLayoutConstraint!
    
    let messageLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpButton.layer.cornerRadius = 4
        signUpButton.layer.masksToBounds = true
        
        messageLabel.frame = CGRect(x: 0, y: 0, width: messageBackground.frame.size.width, height: messageBackground.frame.size.height)
        messageLabel.font = UIFont(name: "HelveticaNeue", size: 18.0)
        messageLabel.textColor = UIColor(red: 228.0/255.0, green: 98.0/255.0, blue: 0.0, alpha: 1.0)
        messageLabel.textAlignment = .center
        messageBackground.addSubview(messageLabel)
        
        messageBackground.isHidden = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // nastavenie počiatočnej hodnoty x-constraints spôsobí že sa objekty nezobrazia
        welcomeCenterX.constant -= view.bounds.width
        signUpCenterX.constant -= view.bounds.width
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // v UI s autolayoutom animujeme constraints namiesto súradníc!!!
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            // 1. nastaviť constraint
            self.welcomeCenterX.constant += self.view.bounds.width
            // 2. invalidate layout
            self.view.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 20, options: [], animations: {
            self.signUpCenterX.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
            }, completion: nil)

    }

    @IBAction func signUp(_ sender: AnyObject) {
        signUpButton.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.signUpButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: animateMessages)
    }
    
    private func animateMessages(_: Bool) {
        self.messageLabel.text = "Signing up..."
        UIView.transition(with: self.messageBackground, duration: 0.33, options: [.curveEaseOut, .transitionCurlDown], animations: {
            self.messageBackground.isHidden = false
        }, completion: self.animateMessageSwap)
    }
    
    private func animateMessageSwap(_: Bool) {
        UIView.animate(withDuration: 0.33, delay: 1, options: .curveEaseOut, animations: {
            self.messageBackgroundCenterX.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: self.animateSignedOKFlyIn)
    }
    
    private func animateSignedOKFlyIn(_: Bool) {
        self.messageBackgroundCenterX.constant -= self.view.bounds.width
        self.messageBackground.isHidden = true
        self.messageLabel.text = "Signed OK!"
        
        UIView.transition(with: self.messageBackground, duration: 0.33, options: [.curveEaseOut, .transitionCurlDown], animations: {
            self.messageBackground.isHidden = false
        }, completion: self.animateSignedOKFlyOut)
    }
    
    private func animateSignedOKFlyOut(_: Bool) {
        UIView.animate(withDuration: 0.33, delay: 0.5, options: .curveEaseOut, animations: {
            self.messageBackgroundCenterX.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
        }) { _ in
            self.messageBackgroundCenterX.constant -= self.view.bounds.width
            self.messageBackground.isHidden = true
            self.messageLabel.text = nil
        }
    }

}
