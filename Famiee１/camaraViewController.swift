//
//  camaraViewController.swift
//  Famiee１
//
//  Created by 高岸　憲伸 on 2019/03/15.
//  Copyright © 2019 高岸　憲伸. All rights reserved.
//

import UIKit
import AVFoundation

    class camaraViewController: UIViewController {
        
        // デバイスからの入力と出力を管理するオブジェクトの作成
        var captureSession = AVCaptureSession()
        // カメラデバイスそのものを管理するオブジェクトの作成
        // メインカメラの管理オブジェクトの作成
        var mainCamera: AVCaptureDevice?
        // インカメの管理オブジェクトの作成
        var innerCamera: AVCaptureDevice?
        // 現在使用しているカメラデバイスの管理オブジェクトの作成
        var currentDevice: AVCaptureDevice?
        // キャプチャーの出力データを受け付けるオブジェクト
        var photoOutput : AVCapturePhotoOutput?
        // プレビュー表示用のレイヤ
        var cameraPreviewLayer : AVCaptureVideoPreviewLayer?
        // シャッターボタン
        
         var uiImage = UIImage()
        @IBOutlet weak var cameraButton: UIButton!
        var data:NSData = NSData()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupCaptureSession()
            setupDevice()
            setupInputOutput()
            setupPreviewLayer()
            captureSession.startRunning()
            styleCaptureButton()
        }
        
        
        // シャッターボタンが押された時のアクション
        @IBAction func cameraButton_TouchUpInside(_ sender: Any) {
            let settings = AVCapturePhotoSettings()
            // フラッシュの設定
            settings.flashMode = .off

            // カメラの手ぶれ補正
            settings.isAutoStillImageStabilizationEnabled = true
            // 撮影された画像をdelegateメソッドで処理
            self.photoOutput?.capturePhoto(with: settings, delegate: self as! AVCapturePhotoCaptureDelegate)
            
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(camaraViewController.changeView), userInfo: nil, repeats: false)
            
            
        }
        
        @objc func changeView() {
            
            let ckeckImageViewController = self.storyboard?.instantiateViewController(withIdentifier: "ImageVC") as! ckeckImageViewController
            self.navigationController?.pushViewController(ckeckImageViewController, animated: true)
        }
        
    }
    
    
    
    
    //MARK: AVCapturePhotoCaptureDelegateデリゲートメソッド
    extension camaraViewController: AVCapturePhotoCaptureDelegate{
        // 撮影した画像データが生成されたときに呼び出されるデリゲートメソッド
        func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
            if let imageData = photo.fileDataRepresentation() {
                // Data型をUIImageオブジェクトに変換
                uiImage = UIImage(data: imageData)!
            
                var data:NSData = NSData()

                data = uiImage.jpegData(compressionQuality: 0.1)! as NSData

                let base64String = data.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)as String

                UserDefaults.standard.set(base64String, forKey: "Image")
                
            }
        }
    }
    
    //MARK: カメラ設定メソッド
    extension camaraViewController{
        // カメラの画質の設定
        func setupCaptureSession() {
            captureSession.sessionPreset = AVCaptureSession.Preset.photo
        }
        
        // デバイスの設定
        func setupDevice() {
            // カメラデバイスのプロパティ設定
            let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
            // プロパティの条件を満たしたカメラデバイスの取得
            let devices = deviceDiscoverySession.devices
            
            for device in devices {
                if device.position == AVCaptureDevice.Position.back {
                    mainCamera = device
                } else if device.position == AVCaptureDevice.Position.front {
                    innerCamera = device
                }
            }
            // 起動時のカメラを設定
            currentDevice = mainCamera
        }
        
        // 入出力データの設定
        func setupInputOutput() {
            do {
                // 指定したデバイスを使用するために入力を初期化
                let captureDeviceInput = try AVCaptureDeviceInput(device: currentDevice!)
                // 指定した入力をセッションに追加
                captureSession.addInput(captureDeviceInput)
                // 出力データを受け取るオブジェクトの作成
                photoOutput = AVCapturePhotoOutput()
                // 出力ファイルのフォーマットを指定
                photoOutput!.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])], completionHandler: nil)
                captureSession.addOutput(photoOutput!)
            } catch {
                print(error)
            }
        }
        
        // カメラのプレビューを表示するレイヤの設定
        func setupPreviewLayer() {
            // 指定したAVCaptureSessionでプレビューレイヤを初期化
            self.cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            // プレビューレイヤが、カメラのキャプチャーを縦横比を維持した状態で、表示するように設定
            self.cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            // プレビューレイヤの表示の向きを設定
            self.cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
            
            self.cameraPreviewLayer?.frame = view.frame
            self.view.layer.insertSublayer(self.cameraPreviewLayer!, at: 0)
        }
        
        // ボタンのスタイルを設定
        func styleCaptureButton() {
            cameraButton.layer.borderColor = UIColor.white.cgColor
            cameraButton.layer.borderWidth = 5
            cameraButton.clipsToBounds = true
            cameraButton.layer.cornerRadius = min(cameraButton.frame.width, cameraButton.frame.height) / 2
        }
}

