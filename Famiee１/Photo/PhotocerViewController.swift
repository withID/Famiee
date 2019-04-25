//
//  PhotocerViewController.swift
//  Famiee１
//
//  Created by taiki on 2019/04/25.
//  Copyright © 2019 高岸　憲伸. All rights reserved.
//

import UIKit

class PhotocerViewController: UIViewController {

    @IBOutlet var withName: UILabel!
    @IBOutlet var withPhoto: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let name1 = UserDefaults.standard.object(forKey: "name1") as! String
        let name2 = UserDefaults.standard.object(forKey: "name2") as! String
        withName.text = "\(name1)&\(name2)"
        
        let UserImage =   UserDefaults.standard.object(forKey: "userImage") as! Data
        
        let png = UIImage(data: UserImage)!
        withPhoto.image = png
        // Do any additional setup after loading the view.
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
