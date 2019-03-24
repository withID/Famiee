//
//  Signature2ViewController.swift
//  Famiee１
//
//  Created by taiki on 2019/03/23.
//  Copyright © 2019 高岸　憲伸. All rights reserved.
//

import UIKit
import ACEDrawingView

class Signature2ViewController: UIViewController {

    var image  = UIImage()
    

    @IBOutlet var ViewCC: UIView!
    @IBOutlet var dug2: ACEDrawingView!
    override func viewDidLoad() {
        super.viewDidLoad()

        dug2.lineWidth = 3.0
        // ACEDrawingViewの枠の線を設定
        dug2.layer.borderWidth = 0
        dug2.layer.cornerRadius = 20
        
        ViewCC.layer.borderWidth = 1.0
        ViewCC.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
    }
    

    @IBAction func done2(_ sender: Any) {
        
        UIGraphicsBeginImageContextWithOptions(dug2.frame.size, false, 1)
        
        dug2.layer.render(in: UIGraphicsGetCurrentContext()!)
        image = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        let data = image.pngData() as NSData?
        if let imageData = data {
            UserDefaults.standard.set(imageData, forKey: "Sign2Image")
        }
        // 添付ファイルの対象カラムを設定
        
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
