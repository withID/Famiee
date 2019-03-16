//
//  CheckViewController.swift
//  Famiee１
//
//  Created by 高岸　憲伸 on 2019/03/12.
//  Copyright © 2019 高岸　憲伸. All rights reserved.
//

import UIKit

class CheckViewController: UIViewController {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var ChikaiLabel: UILabel!
    
    var Chikai = String()
    var name = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //遷移先Viewの左上のbackを消す
        let myBackButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = myBackButton
        
        nameLabel.text = name
        ChikaiLabel.text = Chikai
    }
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // ナビゲーションを透明にする処理
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
    }
}
