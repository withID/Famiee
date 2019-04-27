//
//  wPSIgnedViewController.swift
//  Famiee１
//
//  Created by taiki on 2019/04/26.
//  Copyright © 2019 高岸　憲伸. All rights reserved.
//

import UIKit

class wPSIgnedViewController: UIViewController {

        @IBOutlet var box: UIView!
        var image = UIImage()
        
        @IBOutlet var sign1: UIImageView!
        @IBOutlet var sign2: UIImageView!
        @IBOutlet var firstname: UILabel!
        @IBOutlet var firstmessage: UILabel!
        @IBOutlet var secoundmessage: UILabel!
        
    @IBOutlet var withPhoto: UIImageView!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            //遷移先Viewの左上のbackを消す
            let myBackButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            self.navigationItem.backBarButtonItem = myBackButton
            
            box.layer.cornerRadius = 5
            
            let firstName = UserDefaults.standard.object(forKey: "Name") as! String
            let secoundName = UserDefaults.standard.object(forKey: "Name2Text") as! String
            
            firstname.text = "\(firstName) & \(secoundName)"
            let firstMessage = UserDefaults.standard.object(forKey: "Message") as! String
            firstmessage.text = firstMessage
            
            let secoundMessage = UserDefaults.standard.object(forKey: "Message2") as! String
            secoundmessage.text = secoundMessage
            
            let imagedata1 = UserDefaults.standard.object(forKey: "Sign1Image")
            sign1.image = UIImage(data: imagedata1 as! Data)
            
            let imagedata2 = UserDefaults.standard.object(forKey: "Sign2Image")
            sign2.image = UIImage(data: imagedata2 as! Data)
            let UserImage =   UserDefaults.standard.object(forKey: "userImage") as! Data
            
            let png = UIImage(data: UserImage)!
            withPhoto.image = png
        }
        
        @IBAction func `return`(_ sender: Any) {
            self.navigationController?.popViewController(animated: true)
            
        }
        
        
        @IBAction func done(_ sender: Any) {
            UIGraphicsBeginImageContextWithOptions(box.frame.size, false, 1)
            
            box.layer.render(in: UIGraphicsGetCurrentContext()!)
            image = UIGraphicsGetImageFromCurrentImageContext()!
            
            UIGraphicsEndImageContext()
            
            let data = image.pngData() as NSData?
            if let imageData = data {
                UserDefaults.standard.set(imageData, forKey: "box")
            }
            
        }
        
}

