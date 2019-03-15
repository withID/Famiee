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

        nameLabel.text = name
        ChikaiLabel.text = Chikai
    }
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
