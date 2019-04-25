//
//  PrintViewController.swift
//  Famiee１
//


import UIKit
import CoreImage


class PrintViewController: UIViewController {
    @IBOutlet var overView: UIView!
    @IBOutlet var underView: UIView!
    
    @IBOutlet var sign1: UIImageView!
    @IBOutlet var sign2: UIImageView!
    
    @IBOutlet var firstname: UILabel!
    @IBOutlet var firstmessage: UILabel!
    @IBOutlet var secoundmessage: UILabel!
    @IBOutlet var pass: UILabel!
    @IBOutlet var qrImage: UIImageView!
    
    
    var printingImage: UIImage?
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overView.layer.cornerRadius = 40
        underView.layer.cornerRadius = 5
        
        let firstName = UserDefaults.standard.object(forKey: "Name") as! String
        let secoundName = UserDefaults.standard.object(forKey: "Name2Text") as! String
        firstname.text = "\(firstName)&\(secoundName)"
        let firstMessage = UserDefaults.standard.object(forKey: "Message") as! String
        firstmessage.text = firstMessage
        
        let secoundMessage = UserDefaults.standard.object(forKey: "Message2") as! String
        secoundmessage.text = secoundMessage
        
        let imagedata1 = UserDefaults.standard.object(forKey: "Sign1Image")
        sign1.image = UIImage(data: imagedata1 as! Data)
        
        let imagedata2 = UserDefaults.standard.object(forKey: "Sign2Image")
        sign2.image = UIImage(data: imagedata2 as! Data)
        
        pass.text = "パスワード:\(UserDefaults.standard.object(forKey: "key") as! String)"
        
        
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
        
        let txid = UserDefaults.standard.object(forKey: "TxID") as! String
        let url = "https://etherscan.io/tx/\(txid)"
        // NSString から NSDataへ変換
        let data = url.data(using: String.Encoding.utf8)!
        
        // QRコード生成のフィルター
        // NSData型でデーターを用意
        // inputCorrectionLevelは、誤り訂正レベル
        let qr = CIFilter(name: "CIQRCodeGenerator", parameters: ["inputMessage": data, "inputCorrectionLevel": "M"])!
        
        
        let sizeTransform = CGAffineTransform(scaleX: 10, y: 10)
        let qrImages = qr.outputImage!.transformed(by: sizeTransform)
        
        qrImage.image = UIImage(ciImage: qrImages)
        
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
    
}
