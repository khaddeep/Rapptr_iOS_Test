//
//  ChatTableViewCell.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Setup cell to match mockup
     *
     * 2) Include user's avatar image
     **/
    
    // MARK: - Outlets
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var userImage: UIImageView!{
        didSet{
            userImage.layer.masksToBounds = false
            userImage.layer.cornerRadius = userImage.frame.size.width / 2
            userImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bubbleView: UIView! {
        didSet{
            bubbleView.layer.borderWidth = 1.0
            bubbleView.layer.cornerRadius = 8.0
            let bubbleColor = hexStringToUIColor(hex: "#EFEFEF")
            bubbleView.layer.borderColor = bubbleColor.cgColor
        }
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // MARK: - Public
    func setCellData(message: Message) {
        header.text = message.username
        body.text = message.text
        let url = message.avatarURL
        
    }
    
    
    func hexStringToUIColor (hex:String) -> UIColor {
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
}
