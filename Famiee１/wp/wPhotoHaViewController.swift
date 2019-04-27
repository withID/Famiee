//
//  wPhotoHaViewController.swift
//  Famiee１
//
//  Created by taiki on 2019/04/26.
//  Copyright © 2019 高岸　憲伸. All rights reserved.
//

import UIKit

class wPhotoHaViewController: UIViewController {
        @IBOutlet var box: UIView!
        
        @IBOutlet var firstname: UILabel!
        @IBOutlet var firstmessage: UILabel!
        @IBOutlet var secoundmessage: UILabel!
        
    @IBOutlet var withPhoto: UIImageView!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            //遷移先Viewの左上のbackを消す
            let myBackButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            self.navigationItem.backBarButtonItem = myBackButton
            
            box.layer.cornerRadius = 40
            
            let firstName = UserDefaults.standard.object(forKey: "Name") as! String
            let secoundName = UserDefaults.standard.object(forKey: "Name2Text") as! String
            firstname.text = "\(firstName) & \(secoundName)"
            
            let firstMessage = UserDefaults.standard.object(forKey: "Message") as! String
            firstmessage.text = firstMessage
            let secoundMessage = UserDefaults.standard.object(forKey: "Message2") as! String
            secoundmessage.text = secoundMessage
            
            let UserImage =   UserDefaults.standard.object(forKey: "userImage") as! Data
            
            let png = UIImage(data: UserImage)!
            withPhoto.image = png
        }
        
}
