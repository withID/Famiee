//
//  Check2ViewController.swift
//  Famiee１
//

import UIKit

class Check2ViewController: UIViewController {

    @IBOutlet var nameLabel3: UILabel!
    @IBOutlet var ChikaiLabel3: UITextView!
    

    
    var name2 = String()
    var chikai2 = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //遷移先Viewの左上のbackを消す
        let myBackButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = myBackButton
        
        nameLabel3.text = name2
        ChikaiLabel3.text = chikai2
        
    }
    @IBAction func back2(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        
        if UserDefaults.standard.object(forKey: "Photo") as! String == "true" {
            
            let wPhotoHaViewController = self.storyboard?.instantiateViewController(withIdentifier: "wpVC") as! wPhotoHaViewController
            self.navigationController?.pushViewController(wPhotoHaViewController, animated: true)
            
            
        }else{
            
            let HakkouViewController = self.storyboard?.instantiateViewController(withIdentifier: "HakkouVC") as! HakkouViewController
            self.navigationController?.pushViewController(HakkouViewController, animated: true)
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // ナビゲーションを透明にする処理
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
    }
}
