//
//  UIViewAnimationPosAndSizeViewController.swift
//  AnimationsDemo
//
//  Created by Lubos Ilcik on 29/11/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit

class UIViewAnimationPosAndSizeViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var messageBackground: UIImageView!
    let messageLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Position & Size Anim"

        // nastavenie cornerRadius a masksToBounds spôsobí zaoblenie
        signUpButton.layer.cornerRadius = 4
        signUpButton.layer.masksToBounds = true
        signUpButton.isHidden = false
        
        // pridanie UILabel programovo s nastavením rozmerov a pozície
        messageLabel.frame = CGRect(x: 0, y: 0, width: messageBackground.frame.size.width, height: messageBackground.frame.size.height)
        messageLabel.font = UIFont(name: "HelveticaNeue", size: 18.0)
        messageLabel.textColor = UIColor(red: 228.0/255.0, green: 98.0/255.0, blue: 0.0, alpha: 1.0)
        messageLabel.textAlignment = .center
        messageBackground.addSubview(messageLabel)
        
        // nastavenie hidden = true spôsobí nezobrazenie
        messageBackground.isHidden = true

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 1. nastav center.x aby východzia pozície bola mimo bounds
        welcomeLabel.center.x -= view.bounds.width
        signUpButton.center.x -= view.bounds.width
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // 2. animovaním zmeny x-polohy dosiahneš "vplávanie" objektov

        // varianta animácie s easing funkciou
        
        // options: .curveEaseInOut, .curveEaseIn, .curveEaseOut, .curveEaseLinear
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.welcomeLabel.center.x += self.view.bounds.width
        }, completion: nil)

        // varianta animácie so spring funkciou

        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 20, options: [], animations: {
            self.signUpButton.center.x += self.view.bounds.width
            }, completion: nil)

    }
    
    // príklad animation chaining
    @IBAction func signUp(_ sender: AnyObject) {
        
        // animácia veľkosti s CGAffineTransform
        signUpButton.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseOut,
                       animations: {
                                        self.signUpButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                       },
                       completion: animateMessages /* nil */)

    }
    
    private func animateMessages(_: Bool) {

        // animácia hidden property s UIView.transition
        self.messageLabel.text = "Signing up..."
        UIView.transition(with: self.messageBackground, duration: 0.33, options: [.curveEaseOut, .transitionCurlDown],
                          animations: {
                                        self.messageBackground.isHidden = false
                          },
                          completion: animateMessageSwap /* nil */)
        
    }
    
    private func animateMessageSwap(_: Bool) {
        UIView.animate(withDuration: 0.33, delay: 1, options: .curveEaseOut,
                       animations: {
                                        self.messageBackground.center.x += self.view.bounds.width
                       },
                       completion: animateSignedOKFlyIn /* nil */)
    }
    
    private func animateSignedOKFlyIn(_: Bool) {
        self.messageBackground.center.x -= self.view.bounds.width
        self.messageBackground.isHidden = true
        self.messageLabel.text = "Signed OK!"
        UIView.transition(with: self.messageBackground, duration: 0.33, options: [.curveEaseOut, .transitionCurlDown],
                          animations: {
                                        self.messageBackground.isHidden = false
                          },
                          completion: animateSignedOKFlyOut /* nil */)
    }
    
    private func animateSignedOKFlyOut(_: Bool) {
        UIView.animate(withDuration: 0.33, delay: 1, options: .curveEaseOut, animations: {
            self.messageBackground.center.x += self.view.bounds.width
        }) { _ in
            self.messageBackground.center.x -= self.view.bounds.width
            self.messageBackground.isHidden = true
            self.messageLabel.text = nil
        }
    }
}
