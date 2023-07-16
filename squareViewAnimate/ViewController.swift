//
//  ViewController.swift
//  squareViewAnimate
//
//  Created by Alexander Ischenko on 16.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Variables
    
    var squareView = UIView()
    var animator = UIDynamicAnimator()
    var snapBehavior : UISnapBehavior?
    
    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        createSquareView()
        createGesture()
        createAnimatorAndBehaviors()

    }
    
    //MARK: - Private Methods
    
    private func createSquareView() {
        squareView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        squareView.backgroundColor = .blue
        squareView.center = view.center
        squareView.layer.cornerRadius = 10
        view.addSubview(squareView)
    }
    
    
    private func createGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(param:)))
        view.addGestureRecognizer(tap)
    }
    
    private func createAnimatorAndBehaviors() {
        animator = UIDynamicAnimator(referenceView: view)
        let collision = UICollisionBehavior(items: [squareView])
        collision.translatesReferenceBoundsIntoBoundary = false
        animator.addBehavior(collision)
        
        snapBehavior = UISnapBehavior(item: squareView, snapTo: squareView.center)
        snapBehavior?.damping = 0.5
        animator.addBehavior(snapBehavior!)
        
    }
    
    //MARK: - objc func
    
    @objc private func tapped(param: UITapGestureRecognizer) {
        
        let tapPoint = param.location(in: view)
        if snapBehavior != nil {
            animator.removeBehavior(snapBehavior!)
        }
        snapBehavior = UISnapBehavior(item: squareView, snapTo: tapPoint)
        snapBehavior?.damping = 0.5
        animator.addBehavior(snapBehavior!)
    }
    
}

