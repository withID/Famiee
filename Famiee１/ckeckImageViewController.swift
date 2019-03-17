//
//  ckeckImageViewController.swift
//  Famiee１
//
//  Created by taiki on 2019/03/17.
//  Copyright © 2019 高岸　憲伸. All rights reserved.
//

import UIKit

class ckeckImageViewController: UIViewController {

    @IBOutlet var Image: UIImageView!
    var TakedImage = UIImage()
    var ImageString = String()
    override func viewDidLoad() {
        super.viewDidLoad()

//         Do any additional setup after loading the view.
        
        ImageString = UserDefaults.standard.object(forKey: "Image") as! String
        
        let decodedData = NSData(base64Encoded: ImageString as! String , options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
        let decodeImage = UIImage(data: decodedData! as Data)
    
        Image.layer.cornerRadius = 8.0
        Image.clipsToBounds = true
        
        Image.image = decodeImage
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
