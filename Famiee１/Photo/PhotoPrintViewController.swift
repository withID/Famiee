//
//  PhotoPrintViewController.swift
//  Famiee１
//
//  Created by taiki on 2019/04/26.
//  Copyright © 2019 高岸　憲伸. All rights reserved.
//


import UIKit
import CoreImage
    
    
    class PhotoPrintViewController: UIViewController {
        @IBOutlet var overView: UIView!
        @IBOutlet var underView: UIView!
        
        @IBOutlet var sign1: UIImageView!
        @IBOutlet var sign2: UIImageView!
        
        @IBOutlet var withPhoto: UIImageView!
        @IBOutlet var firstname: UILabel!
        @IBOutlet var pass: UILabel!
        @IBOutlet var qrImage: UIImageView!
        
        
        var printingImage: UIImage?
        var image = UIImage()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            overView.layer.cornerRadius = 40
            underView.layer.cornerRadius = 5
            
            let firstName = UserDefaults.standard.object(forKey: "name1") as! String
            let secoundName = UserDefaults.standard.object(forKey: "name2") as! String
            firstname.text = "\(firstName) & \(secoundName)"

           
            let imagedata1 = UserDefaults.standard.object(forKey: "Sign1Image")
            sign1.image = UIImage(data: imagedata1 as! Data)
            
            let imagedata2 = UserDefaults.standard.object(forKey: "Sign2Image")
            sign2.image = UIImage(data: imagedata2 as! Data)
            
            if UserDefaults.standard.object(forKey: "check") as! String == "" {
                pass.text = "パスワード : \(UserDefaults.standard.object(forKey: "key") as! String)"
                pass.alpha = 0
                
            }else{
                
                pass.text = "パスワード : \(UserDefaults.standard.object(forKey: "key") as! String)"
            }
            let txid = UserDefaults.standard.object(forKey: "TxID") as! String
            let url = "https://famieepj.herokuapp.com/\(txid)"
            // NSString から NSDataへ変換
            let data = url.data(using: String.Encoding.utf8)!
            
            // QRコード生成のフィルター
            // NSData型でデーターを用意
            // inputCorrectionLevelは、誤り訂正レベル
            let qr = CIFilter(name: "CIQRCodeGenerator", parameters: ["inputMessage": data, "inputCorrectionLevel": "M"])!
            
            
            let sizeTransform = CGAffineTransform(scaleX: 10, y: 10)
            let qrImages = qr.outputImage!.transformed(by: sizeTransform)
            
            qrImage.image = UIImage(ciImage: qrImages)
            
            let UserImage = UserDefaults.standard.object(forKey: "userImage")
            
            let png = UIImage(data: UserImage as! Data)!
            withPhoto.image = png
            UIGraphicsBeginImageContextWithOptions(underView.frame.size, false, 0.0)
            
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
        
        override func viewWillAppear(_ animated: Bool) {
            (UINavigationBar.appearance() as UINavigationBar).setBackgroundImage(UIImage(), for: .default)
            UINavigationBar.appearance().shadowImage = UIImage()
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
        
        @IBAction func savePhoto(_ sender: Any) {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.showResultOfSaveImage(_:didFinishSavingWithError:contextInfo:)), nil)
        }
        
        // 保存を試みた結果をダイアログで表示
        @objc func showResultOfSaveImage(_ image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutableRawPointer) {
            
            var title = "保存完了"
            var message = "カメラロールに保存しました"
            
            if error != nil {
                title = "エラー"
                message = "保存に失敗しました"
            }
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            // OKボタンを追加
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            // UIAlertController を表示
            self.present(alert, animated: true, completion: nil)
        }
        
        @IBAction func done(_ sender: Any) {
            let appDomain = Bundle.main.bundleIdentifier
            UserDefaults.standard.removePersistentDomain(forName: appDomain!)
        }
        
        
}

