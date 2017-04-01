//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

public class IntroViewController: UIViewController {
    
    var margins = UILayoutGuide()
    
    let rocketView: RocketView = {
        var rocket = RocketView()
        rocket.translatesAutoresizingMaskIntoConstraints = false
        rocket.backgroundColor = .clear
        rocket.alpha = 0
        return rocket
    }()
    
    var planetView: PlanetView = {
        var planet = PlanetView()
        planet.translatesAutoresizingMaskIntoConstraints = false
        planet.backgroundColor = .clear
        planet.alpha = 0
        return planet
    }()
    
    override public func loadView() {
        view = UIView()
        view.backgroundColor = .white
    }
    
    override public func viewDidLoad() {
        margins = view.layoutMarginsGuide
        setupViews3()
    }
    
    
    func setupViews2() {
        view.addSubview(rocketView)
        rocketView.heightAnchor.constraint(equalToConstant: 181).isActive = true
        rocketView.widthAnchor.constraint(equalToConstant: 81).isActive = true
        rocketView.centerXAnchor.constraint(equalTo: margins.centerXAnchor, constant: 0).isActive = true
        rocketView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: 181).isActive = true
        
        self.rocketLaunch()
    }
    
    func rocketLaunch() {
        //animate bg
        self.rocketView.alpha = 1
        UIView.animate(withDuration: 3, animations: {
            self.view.backgroundColor = UIColor(red:0.20, green:0.29, blue:0.37, alpha:1.00)
        }) { (complete) in
            self.rocketMove()
        }
    }
    
    var setupViews2Count = 1

    func rocketMove() {
        UIView.animate(withDuration: 2, animations: {
            self.rocketView.frame.origin.y -= (self.rocketView.frame.height + 30)
            self.rocketView.flameAlpha = 0
        }) { (complete) in
            
            UIView.animate(withDuration: 2, animations: {
                self.rocketView.flameAlpha = 1
                self.rocketView.frame.origin.y -= (self.view.bounds.height + (self.rocketView.frame.height))
            }, completion: { (complete) in
                self.setupViews3()
            })
        }
        
    }
    
    var planetViewHeightConstraint: NSLayoutConstraint!
    var planetViewWidthConstraint: NSLayoutConstraint!
    var planetViewTopConstraint: NSLayoutConstraint!
    var planetViewRightConstraint: NSLayoutConstraint!
    
    func setupViews3() {
        
//        view.addSubview(rocketView)
        rocketView.removeFromSuperview()
        view.addSubview(rocketView)
        view.addSubview(planetView)
        
        rocketView.heightAnchor.constraint(equalToConstant: 181).isActive = true
        rocketView.widthAnchor.constraint(equalToConstant: 81).isActive = true
        rocketView.centerXAnchor.constraint(equalTo: margins.centerXAnchor, constant: 0).isActive = true
        rocketView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: 181).isActive = true
        
        planetViewHeightConstraint = planetView.heightAnchor.constraint(equalToConstant: 160)
        planetViewWidthConstraint = planetView.widthAnchor.constraint(equalToConstant: 160)
        
        planetViewWidthConstraint.isActive = true
        planetViewHeightConstraint.isActive = true

        planetViewTopConstraint = planetView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 19)
        planetViewRightConstraint = planetView.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: -21
        )
        planetViewTopConstraint.isActive = true
        planetViewRightConstraint.isActive = true
        
//        planetView.centerXAnchor.constraint(equalTo: margins.centerXAnchor, constant: 0).isActive = true
//        planetView.centerYAnchor.constraint(equalTo: margins.centerYAnchor, constant: 0).isActive = true
        
        
//        planetView.alpha = 1
        setupViews3Scene1()
    }
    
    func setupViews3Scene1() {
        self.rocketView.alpha = 0
        UIView.animate(withDuration: 3, animations: {
            self.planetView.alpha = 1
        }) { (complete) in
            UIView.animate(withDuration: 3, animations: {
                self.planetViewHeightConstraint.constant *= 3
                self.planetViewWidthConstraint.constant *= 3
                
                self.planetView.setNeedsDisplay()

                self.view.layoutIfNeeded()
                
            }, completion: { (_) in
                
                
            })
            
        }
        
    }
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    
    func funBox() {
        let box = UIView(frame: CGRect(x: 100, y: 100, width: 50, height: 50))
        box.backgroundColor = .white
        view.addSubview(box)
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [box])
        gravity.magnitude = 0.1
        animator.addBehavior(gravity)
        collision = UICollisionBehavior(items: [box])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        let itemBehaviour = UIDynamicItemBehavior(items: [box])
        itemBehaviour.elasticity = 0.6
        animator.addBehavior(itemBehaviour)
    }

}

class RocketView: UIView {
    
    private var _flameAlpha: CGFloat = 1.0
    private var _flameHeight: CGFloat = 1.0
    
    var flameAlpha: CGFloat {
        set (newAlpha) {
            _flameAlpha = newAlpha
            setNeedsDisplay()
        } get {
            return _flameAlpha
        }
    }
    
    var flameHeight: CGFloat {
        set (newHeight) {
            _flameHeight = newHeight
            setNeedsDisplay()
        } get {
            return _flameHeight
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        IntroStyleKit.drawRocketWithFlame(frame: bounds, resizing: .stretch, flameAlpha: flameAlpha, flameScaleInHeight: flameHeight)
    }
}

class PlanetView: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        IntroStyleKit.drawPlanetPlayground(frame: bounds, resizing: .stretch)
    }
}

let introVC = IntroViewController()
PlaygroundPage.current.liveView = introVC

