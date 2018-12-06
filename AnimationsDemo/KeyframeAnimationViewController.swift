//
//  KeyframeAnimationViewController.swift
//  AnimationsDemo
//
//  Created by Lubos Ilcik on 30/11/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit

class KeyframeAnimationViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func dismiss(_ sender: AnyObject) {
        
        // výpočet rozmerov a pozície
        let bounds = containerView.bounds
        // frame pre medzistav = v centre dispaleja a zmenšený na štvrtinu
        let smallFrame = containerView.frame.insetBy(dx: containerView.frame.size.width / 4, dy: containerView.frame.size.height / 4)
        // frame pre finálny stav = odsunutý o výšku displeja pod spodnú hranu
        let finalFrame = smallFrame.offsetBy(dx: 0, dy: bounds.size.height)

        // snapshot poslúži ako dočasné view pre animáciu
        let snapshot = containerView.snapshotView(afterScreenUpdates: false)
        snapshot?.frame = containerView.frame
        view.addSubview(snapshot!)
        // snapshot nahradí pôvodné view
        containerView.removeFromSuperview()
        
        // príklad key frame animation so snapshot view
        UIView.animateKeyframes(withDuration: 0.8, delay: 0, options: .calculationModeCubic, animations: {
        
            // prvý frame - start time je 0% od začiatku a dĺžka animácie je 20% z celkovej dĺžky
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2) {
                snapshot?.frame = smallFrame
            }
            // druhý frame - start time je 20% od začiatku a dĺžka animácie je 80% z celkovej dĺžky
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.8) {
                snapshot?.frame = finalFrame
            }
            
        }, completion: nil)

    }
    
}
