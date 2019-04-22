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
    @IBOutlet var ChikaiText2: PlaceHolderTextView!
    @IBOutlet var nextButton2: UIButton!
    @IBOutlet var checkedBtn: UIButton!
    var isChecked = true
    override func viewDidLoad() {
        super.viewDidLoad()
        //遷移先Viewの左上のbackを消す
        let myBackButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = myBackButton
        
        ChikaiText2.font = UIFont.systemFont(ofSize: 21)
        
        nameText2.delegate = self
        ChikaiText2.delegate = self
        
        board2.layer.cornerRadius = 5
        nameText2.layer.cornerRadius = 5
        ChikaiText2.layer.cornerRadius = 5
        nameView2.layer.cornerRadius = 5
        ChikaiView2.layer.cornerRadius = 5
        nameText2.returnKeyType = .done
        nameText2.clearButtonMode = .always
        ChikaiText2.returnKeyType = .done
        
        nameText2.delegate = self
        ChikaiText2.delegate = self
        
        ChikaiText2.placeHolder = "あなたがパートナーとの間でかわす誓いのを入力してください"
        ChikaiText2.placeHolderColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.4)
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
        
        if isChecked == false {
            
            let Check2ViewController = self.storyboard?.instantiateViewController(withIdentifier: "toCheck2VC") as! Check2ViewController
            self.navigationController?.pushViewController(Check2ViewController, animated: true)
            //遷移先のBox変数に、このコードないの変数Stringを代入する
            Check2ViewController.name2 = nameText2.text!
            Check2ViewController.chikai2 = ChikaiText2.text!
        }else{
            
            let Check2ViewController = self.storyboard?.instantiateViewController(withIdentifier: "toCheck2CVC") as! Check2ViewController
            self.navigationController?.pushViewController(Check2ViewController, animated: true)
            //遷移先のBox変数に、このコードないの変数Stringを代入する
            Check2ViewController.name2 = nameText2.text!
            Check2ViewController.chikai2 = ChikaiText2.text!
        }
        
        
        UserDefaults.standard.set(nameText2.text, forKey: "Name2Text")
        UserDefaults.standard.set(ChikaiText2.text, forKey: "Message2")
    }
    
    @IBAction func checkView(_ sender: Any) {
        
        let checkoff = UIImage(named: "checkoff.jpg")
        let checkon = UIImage(named: "checkon.jpg")
        if isChecked == false{
            checkedBtn.setImage(checkon, for: .normal)
        }
        else{
            checkedBtn.setImage(checkoff, for: .normal)
        }
        print(isChecked)
        isChecked = !isChecked
    }
    
}
