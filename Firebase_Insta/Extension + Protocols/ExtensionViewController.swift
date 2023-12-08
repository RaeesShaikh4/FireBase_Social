//
//  ExtensionViewController.swift
//  Firebase_Insta
//
//  Created by Vishal on 30/11/23.
//

import UIKit



protocol protocolToSetBG: AnyObject {
    func setBackGroundImage(imageName: String)
}

extension protocolToSetBG where Self: UIViewController {
    func setBackGroundImage(imageName: String) {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: imageName)
        backgroundImage.contentMode = .scaleAspectFill
        
        self.view.addSubview(backgroundImage)
        self.view.sendSubviewToBack(backgroundImage)
    }
}





class ExtensionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}


