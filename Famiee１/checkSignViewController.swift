//
//  checkSignViewController.swift
//  Famiee１
//
//  Created by taiki on 2019/03/23.
//  Copyright © 2019 高岸　憲伸. All rights reserved.
//

import UIKit

class checkSignViewController: UIViewController {

    @IBOutlet var Cer: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let image = UserDefaults.standard.object(forKey: "box")
        Cer.image = UIImage(data: image as! Data)
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
