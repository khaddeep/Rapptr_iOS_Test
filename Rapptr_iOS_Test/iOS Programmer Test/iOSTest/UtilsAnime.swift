//
//  Animate.swift
//  iOSTest
//
//  Created by Dypson Khadka on 13/03/1400 AP.
//
import UIKit
struct UtilsAnime {
    
    func fadeInOut(image: UIImageView, minOpacity: CGFloat, maxOpacity: CGFloat, duration: TimeInterval) {
        image.alpha=minOpacity
        UIView.animate(withDuration: duration, animations:{
            image.alpha=maxOpacity
        })
    }
}
