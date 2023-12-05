//
//  bottom border style.swift
//  Firebase_Insta
//
//  Created by Vishal on 01/12/23.
//

import Foundation
import UIKit

class BottomBorderLabel: UILabel {

    override func awakeFromNib() {
        super.awakeFromNib()
        addBottomBorder(withSpacing: 8.0)
       }

       func addBottomBorder(withSpacing spacing: CGFloat) {
           let bottomBorder = CALayer()
           bottomBorder.frame = CGRect(x: 0.0, y: self.frame.size.height + spacing, width: self.frame.size.width, height: 1.0)
           bottomBorder.backgroundColor = (UIColor(named: "borderLogin") ?? UIColor.black).cgColor
           self.layer.addSublayer(bottomBorder)
       }
}

//class makeImageViewRound {
//    static func makeRound(_ imageView: UIImageView?){
//        guard let imageView = imageView else {
//            return
//        }
//        imageView.layer.cornerRadius = imageView.frame.size
//    }
//}
