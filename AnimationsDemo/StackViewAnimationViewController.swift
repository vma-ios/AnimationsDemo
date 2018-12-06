//
//  StackViewAnimationViewController.swift
//  AnimationsDemo
//
//  Created by Lubos Ilcik on 30/11/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit

class StackViewAnimationViewController: UIViewController {
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var detail: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func hideDetail(_ sender: AnyObject) {
        if detail.isHidden {
            animateView(detail, toHidden: false)
            detailsButton.setTitle("Hide Details", for: UIControl.State())
        } else {
            animateView(detail, toHidden: true)
            detailsButton.setTitle("Show Details", for: UIControl.State())
        }
    }
    
    fileprivate func animateView(_ view: UIView, toHidden hidden: Bool) {
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10.0, options: UIView.AnimationOptions(), animations: { () -> Void in
            view.isHidden = hidden
            }, completion: nil)
    }
}
