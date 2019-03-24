//
//  PrintViewController.swift
//  Famiee１
//
//  Created by 高岸　憲伸 on 2019/03/15.
//  Copyright © 2019 高岸　憲伸. All rights reserved.
//

import UIKit

class PrintViewController: UIViewController {
    @IBOutlet var overView: UIView!
    @IBOutlet var underView: UIView!
    
    @IBOutlet var sign1: UIImageView!
    @IBOutlet var sign2: UIImageView!
    
    @IBOutlet var firstname: UILabel!
    @IBOutlet var firstmessage: UILabel!
    @IBOutlet var secoundname: UILabel!
    @IBOutlet var secoundmessage: UILabel!
    
    var printingImage: UIImage?
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overView.layer.cornerRadius = 40
        underView.layer.cornerRadius = 40
        
        let firstName = UserDefaults.standard.object(forKey: "Name") as! String
        firstname.text = firstName
        let firstMessage = UserDefaults.standard.object(forKey: "Message") as! String
        firstmessage.text = firstMessage
        let secoundName = UserDefaults.standard.object(forKey: "Name2Text") as! String
        secoundname.text = secoundName
        let secoundMessage = UserDefaults.standard.object(forKey: "Message2") as! String
        secoundmessage.text = secoundMessage
        
        let imagedata1 = UserDefaults.standard.object(forKey: "Sign1Image")
        sign1.image = UIImage(data: imagedata1 as! Data)
        
        let imagedata2 = UserDefaults.standard.object(forKey: "Sign2Image")
        sign2.image = UIImage(data: imagedata2 as! Data)
        
        
        
        UIGraphicsBeginImageContextWithOptions(underView.frame.size, false, 1)
        
        underView.layer.render(in: UIGraphicsGetCurrentContext()!)
        image = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
            
        self.printingImage = image
        
        let imageView: UIImageView = UIImageView(image: image)
        let imageAspect: CGFloat = (image.size.height) / (image.size.width)
        imageView.frame = CGRect(x: self.view.bounds.width * 0.05, y: self.view.bounds.height * 0.1, width: self.view.bounds.width * 0.9, height: self.view.bounds.width * 0.9 * imageAspect)
//        self.view.addSubview(imageView)
        
        // 印刷ページへ遷移するためのボタン
        let printButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 410, height: 87))
        printButton.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height - 100)
        printButton.layer.cornerRadius = 40
        printButton.tintColor = UIColor.white
        printButton.backgroundColor = UIColor(hex: "F75C5C")
        printButton.setTitle("印刷する", for: .normal)
        printButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        printButton.addTarget(self, action: #selector(self.showPrinterView(_:)), for: .touchUpInside)
        self.view.addSubview(printButton)
        
    }
    // 印刷ページを表示する
    @objc func showPrinterView(_ sender: UIButton) -> Void {
        let printController = UIPrintInteractionController.shared
        
        let printInfo = UIPrintInfo(dictionary:nil)
        printInfo.outputType = UIPrintInfo.OutputType.general
        printInfo.jobName = "Print Job"
        printInfo.orientation = .portrait
        
        printController.printInfo = printInfo
        printController.printingItem = self.printingImage
        
        printController.present(animated: true, completionHandler: nil)
    }
    
}
