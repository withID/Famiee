//
//  ViewController.swift
//  Famiee１
//
//  Created by 高岸　憲伸 on 2019/03/12.
//  Copyright © 2019 高岸　憲伸. All rights reserved.
//

import UIKit
import RSKImageCropper


class ViewController: UIViewController,RSKImageCropViewControllerDelegate,UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    @IBOutlet var leftBtn: UIButton!
    @IBOutlet var centerBtn: UIButton!
    @IBOutlet var rightBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //遷移先Viewの左上のbackを消す
        let myBackButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = myBackButton
        
        UserDefaults.standard.set("false", forKey: "Photo")
        
    }
    
    @IBAction func changeI(_ sender: Any) {
        
          tappedcamera()

    }
    
    
    @IBAction func changeII(_ sender: Any) {
        UserDefaults.standard.set("true", forKey: "Photo")
        
        tappedcamera()
    }
    
    func imagePickerController(_ imagePicker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image : UIImage = info[.originalImage] as! UIImage
        
        imagePicker.dismiss(animated: false, completion: { () -> Void in
            
            var imageCropVC : RSKImageCropViewController!
            
            imageCropVC = RSKImageCropViewController(image: image, cropMode: RSKImageCropMode.circle)
            
            imageCropVC.moveAndScaleLabel.text = "切り取り範囲を選択"
            imageCropVC.cancelButton.setTitle("キャンセル", for: .normal)
            imageCropVC.chooseButton.setTitle("完了", for: .normal)
            imageCropVC.delegate = self
            
            self.present(imageCropVC, animated: true)
            
        })
        
    }
    
    // 撮影がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
  
    
    func tappedcamera() {
        let sourceType:UIImagePickerController.SourceType =
            UIImagePickerController.SourceType.camera
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.camera){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
        else{
            print("error")
        }
    }
    
    
    func imageCropViewController(_ controller: RSKImageCropViewController, didCropImage croppedImage: UIImage, usingCropRect cropRect: CGRect, rotationAngle: CGFloat) {
        
        
        //もし円形で画像を切り取りし、その画像自体を加工などで利用したい場合
        if controller.cropMode == .circle {
            UIGraphicsBeginImageContext(croppedImage.size)
            let layerView = UIImageView(image: croppedImage)
            layerView.frame.size = croppedImage.size
            layerView.layer.cornerRadius = layerView.frame.size.width * 0.5
            layerView.clipsToBounds = true
            let context = UIGraphicsGetCurrentContext()!
            layerView.layer.render(in: context)
            let capturedImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            let pngData = capturedImage.pngData()!
            //このImageは円形で余白は透過です。
            
            UserDefaults.standard.set(pngData, forKey: "userImage")
            
            if UserDefaults.standard.object(forKey: "Photo") as! String == "true" {
                
                let ChikaiViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcV") as! ChikaiViewController
                
                self.navigationController?.pushViewController(ChikaiViewController, animated: true)
                dismiss(animated: true, completion: nil)
                
                
            }else{
                
                let PhtotoWithViewController = self.storyboard?.instantiateViewController(withIdentifier: "Photowith") as! PhtotoWithViewController
                
                self.navigationController?.pushViewController(PhtotoWithViewController, animated: true)
                dismiss(animated: true, completion: nil)
                
            }
            
            
        }
    }
    
    //トリミング画面でキャンセルを押した時
    func imageCropViewControllerDidCancelCrop(_ controller: RSKImageCropViewController) {
        dismiss(animated: true, completion: nil)
    }
    
}
