//
//  PhotocheckViewController.swift
//  Famiee１
//
//  Created by taiki on 2019/04/25.
//  Copyright © 2019 高岸　憲伸. All rights reserved.
//

import UIKit

class PhotocheckViewController: UIViewController {


    @IBOutlet var name1Label: UILabel!
    @IBOutlet var name2Label: UILabel!
    
    var name1 = String()
    var name2 = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //遷移先Viewの左上のbackを消す
        let myBackButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = myBackButton
        
        name1Label.text = UserDefaults.standard.object(forKey: "name1") as! String
        name2Label.text = UserDefaults.standard.object(forKey: "name2") as! String
    }
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

