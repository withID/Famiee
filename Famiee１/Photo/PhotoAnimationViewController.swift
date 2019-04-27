//
//  PhotoAnimationViewController.swift
//  Famiee１
//
//  Created by taiki on 2019/04/26.
//  Copyright © 2019 高岸　憲伸. All rights reserved.
//

import UIKit
import Lottie

class PhotoAnimationViewController: UIViewController {
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Do any additional setup after loading the view.
            let animationView = LOTAnimationView(name: "animation")
            animationView.frame = CGRect(x: 0, y: 400, width: view.bounds.width/2, height: view.bounds.height)
            animationView.center = self.view.center
            animationView.loopAnimation = true
            animationView.contentMode = .scaleAspectFit
            animationView.animationSpeed = 1
            
            view.addSubview(animationView)
            
            animationView.play()
            Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(AnimeViewController.changeView), userInfo: nil, repeats: false)
            
        }
        
        @objc func changeView() {
            
            let PhotoPrintViewController = self.storyboard?.instantiateViewController(withIdentifier: "toPhotoLastPage") as! PhotoPrintViewController
            self.navigationController?.present(PhotoPrintViewController, animated: true)
            
            print("ここまで言ってる")
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
