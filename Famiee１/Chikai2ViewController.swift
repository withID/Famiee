//
//  Chikai2ViewController.swift
//  Famiee１
//
//  Created by 高岸　憲伸 on 2019/03/14.
//  Copyright © 2019 高岸　憲伸. All rights reserved.
//

import UIKit

class Chikai2ViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate {
    @IBOutlet var board2: UIView!
    @IBOutlet var nameView2: UIView!
    @IBOutlet var ChikaiView2: UIView!
    @IBOutlet var nameText2: UITextField!
    @IBOutlet var ChikaiText2: UITextView!
    @IBOutlet var nextButton2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //遷移先Viewの左上のbackを消す
        let myBackButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = myBackButton
        
        ChikaiText2.font = UIFont.systemFont(ofSize: 21)
        
        nameText2.delegate = self
        ChikaiText2.delegate = self
        
        board2.layer.cornerRadius = 40
        nameText2.layer.cornerRadius = 40
        ChikaiText2.layer.cornerRadius = 40
        nameView2.layer.cornerRadius = 20
        ChikaiView2.layer.cornerRadius = 40
        nameText2.returnKeyType = .done
        nameText2.clearButtonMode = .always
        ChikaiText2.returnKeyType = .done
        
        nameText2.delegate = self
        ChikaiText2.delegate = self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameText2.resignFirstResponder()
        ChikaiText2.resignFirstResponder()
    }
    @IBAction func next2(_ sender: Any) {
        let Check2ViewController = self.storyboard?.instantiateViewController(withIdentifier: "toCheck2VC") as! Check2ViewController
        self.navigationController?.pushViewController(Check2ViewController, animated: true)
        //遷移先のBox変数に、このコードないの変数Stringを代入する
        Check2ViewController.name2 = nameText2.text!
        Check2ViewController.chikai2 = ChikaiText2.text!
        
        UserDefaults.standard.set(nameText2.text, forKey: "Name2Text")
        UserDefaults.standard.set(ChikaiText2.text, forKey: "Message2")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // ナビゲーションを透明にする処理
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
    }
    
    
}
