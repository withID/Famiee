//
//  ViewController.swift
//  Famiee１
//
//  Created by 高岸　憲伸 on 2019/03/12.
//  Copyright © 2019 高岸　憲伸. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var leftBtn: UIButton!
    @IBOutlet var centerBtn: UIButton!
    @IBOutlet var rightBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //遷移先Viewの左上のbackを消す
        let myBackButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = myBackButton
        
        leftBtn.layer.cornerRadius = 25
        centerBtn.layer.cornerRadius = 25
        rightBtn.layer.cornerRadius = 25
        
    }
    
}
