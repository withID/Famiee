//
//  Check2ViewController.swift
//  Famiee１
//
//  Created by 高岸　憲伸 on 2019/03/13.
//  Copyright © 2019 高岸　憲伸. All rights reserved.
//

import UIKit

class Check2ViewController: UIViewController {

    @IBOutlet var nameLabel3: UILabel!
    @IBOutlet var ChikaiLabel3: UITextView!
    
    @IBOutlet var Texts: UILabel!
    
    var name2 = String()
    var chikai2 = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //遷移先Viewの左上のbackを消す
        let myBackButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = myBackButton
        
        nameLabel3.text = name2
        ChikaiLabel3.text = chikai2
        Texts.textColor = UIColor.white
    }
    @IBAction func back2(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // ナビゲーションを透明にする処理
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
    }
}
