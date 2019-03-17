//
//  PrintViewController.swift
//  Famiee１
//
//  Created by 高岸　憲伸 on 2019/03/15.
//  Copyright © 2019 高岸　憲伸. All rights reserved.
//

import UIKit

class PrintViewController: UIViewController {
    @IBOutlet var overView: UIView!
    @IBOutlet var underView: UIView!
    @IBOutlet var LastnameLabel: UILabel!
    @IBOutlet var firstname: UILabel!
    @IBOutlet var firstmessage: UILabel!
    @IBOutlet var secoundname: UILabel!
    @IBOutlet var secoundmessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overView.layer.cornerRadius = 40
        underView.layer.cornerRadius = 40
        
        let firstName = UserDefaults.standard.object(forKey: "Name") as! String
        firstname.text = firstName
        let firstMessage = UserDefaults.standard.object(forKey: "Message") as! String
        firstmessage.text = firstMessage
        let secoundName = UserDefaults.standard.object(forKey: "Name2Text") as! String
        secoundname.text = secoundName
        let secoundMessage = UserDefaults.standard.object(forKey: "Message2") as! String
        secoundmessage.text = secoundMessage
        LastnameLabel.text = firstName + " & " + secoundName
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // ナビゲーションを透明にする処理
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
    }
}
