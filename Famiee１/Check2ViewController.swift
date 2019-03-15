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
    @IBOutlet var ChikaiLabel3: UILabel!
    
    var name2 = String()
    var chikai2 = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel3.text = name2
        ChikaiLabel3.text = chikai2
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
