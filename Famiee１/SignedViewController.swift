//
//  HakkouViewController.swift
//  Famiee１
//
//  Created by 高岸　憲伸 on 2019/03/13.
//  Copyright © 2019 高岸　憲伸. All rights reserved.
//

import UIKit

class SignedViewController: UIViewController {
    @IBOutlet var box: UIView!
    var image = UIImage()
    
    @IBOutlet var sign1: UIImageView!
    @IBOutlet var sign2: UIImageView!
    @IBOutlet var firstname: UILabel!
    @IBOutlet var firstmessage: UILabel!
    @IBOutlet var secoundname: UILabel!
    @IBOutlet var secoundmessage: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //遷移先Viewの左上のbackを消す
        let myBackButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = myBackButton
        
        box.layer.cornerRadius = 40
        
        let firstName = UserDefaults.standard.object(forKey: "Name") as! String
        firstname.text = firstName
        let firstMessage = UserDefaults.standard.object(forKey: "Message") as! String
        firstmessage.text = firstMessage
        let secoundName = UserDefaults.standard.object(forKey: "Name2Text") as! String
        secoundname.text = secoundName
        let secoundMessage = UserDefaults.standard.object(forKey: "Message2") as! String
        secoundmessage.text = secoundMessage
        
        let imagedata1 = UserDefaults.standard.object(forKey: "Sign1Image")
        sign1.image = UIImage(data: imagedata1 as! Data)
        
        let imagedata2 = UserDefaults.standard.object(forKey: "Sign2Image")
        sign2.image = UIImage(data: imagedata2 as! Data)
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

