//
//  Animate.swift
//  iOSTest
//
//  Created by Dypson Khadka on 13/03/1400 AP.
//

import Foundation
import UIKit


struct Utils {
    
    static func showAlertMessageWithOK(message: String, parentView: UIViewController) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        parentView.present(alertController, animated: true, completion: nil)
    }
    
    
    static func showAlertMessage(title: String, message: String, yesButtonTitle: String, noButtonTitle: String, parentView: UIViewController, completion: @escaping (_ value: Bool) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: noButtonTitle, style: .destructive, handler: nil))
        alertController.addAction(UIAlertAction(title: yesButtonTitle, style: .default, handler: { action in
            completion(true)
        }))
        parentView.present(alertController, animated: true, completion: nil)
    }
    
    
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    static func fadeInOut(image: UIImageView, minOpacity: CGFloat, maxOpacity: CGFloat, duration: TimeInterval) {
        image.alpha=minOpacity
        UIView.animate(withDuration: duration, animations:{
            image.alpha=maxOpacity
        })
    }
    
}



extension UIImageView {
    
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
