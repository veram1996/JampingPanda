//
//  ViewController.swift
//  JumpingPanda
//
//  Created by Dheeraj Verma on 05/03/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var pandaImageView: UIImageView!
    
    
    private var snap: UISnapBehavior!
    private var animator: UIDynamicAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func dragPandaToJump(_ sender: UIPanGestureRecognizer) {
        
        let point = sender.translation(in: view)
        pandaImageView.transform = CGAffineTransform(translationX: point.x, y: point.y)
        
        if( sender.state == .ended ) {
            self.startingJumping()
        }
    }
    
    func startingJumping() {
        animator = UIDynamicAnimator(referenceView: self.view)
        self.view.layoutIfNeeded()
        let origin = pandaImageView.center
        pandaImageView.center =  CGPoint(x: self.view.frame.midX, y: self.view.frame.midY)
        
       // For some damping effect
        snap = UISnapBehavior(item: pandaImageView, snapTo: origin)
        snap.damping = 0.3
        
        //For some angle rotation
        let angle = Int(arc4random_uniform(20)) - 10
        let itemBehavior = UIDynamicItemBehavior(items: [pandaImageView])
        itemBehavior.friction = 1
        itemBehavior.addAngularVelocity(CGFloat(angle), for: pandaImageView)
        animator.addBehavior(itemBehavior)
        animator.addBehavior(snap)
        
    }
    
}

