//
//  AnimationViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit


class AnimationViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Logo should fade out or fade in when the user hits the Fade In or Fade Out button
     *
     * 3) User should be able to drag the logo around the screen with his/her fingers
     *
     * 4) Add a bonus to make yourself stick out. Music, color, fireworks, explosions!!! Have Swift experience? Why not write the Animation 
     *    section in Swfit to show off your skills. Anything your heart desires!
     *
     **/
    @IBOutlet weak var btnFadeInOut: UIButton!
    
    @IBOutlet weak var imgLogo: UIImageView!
    
    var isFadedIn: Int=1
    var panGesture       = UIPanGestureRecognizer()
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(AnimationViewController.draggedView(_:)))
            imgLogo.isUserInteractionEnabled = true
            imgLogo.addGestureRecognizer(panGesture)
    }
    
    @objc func draggedView(_ sender:UIPanGestureRecognizer){
        self.view.bringSubviewToFront(imgLogo)
        let translation = sender.translation(in: self.view)
       imgLogo.center = CGPoint(x: imgLogo.center.x + translation.x, y: imgLogo.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    // MARK: - Actions
    @IBAction func backAction(_ sender: Any) {
        let mainMenuViewController = MenuViewController()
        self.navigationController?.pushViewController(mainMenuViewController, animated: true)
    }
    
    @IBAction func didPressFade(_ sender: Any) {
        if isFadedIn==1 {
            Utils.fadeInOut(image: imgLogo, minOpacity: 1, maxOpacity: 0, duration: 3)
            btnFadeInOut.setTitle("Fade Out", for: .normal)
            isFadedIn=0
        }
       else if isFadedIn==0 {
            Utils.fadeInOut(image: imgLogo, minOpacity: 0, maxOpacity: 1, duration: 3)
            btnFadeInOut.setTitle("Fade In", for: .normal)
            isFadedIn=1
        }
    }
}
