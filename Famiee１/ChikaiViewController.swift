//
//  ChikaiViewController.swift
//  Famiee１
//
//  Created by 高岸　憲伸 on 2019/03/12.
//  Copyright © 2019 高岸　憲伸. All rights reserved.
//

import UIKit

class ChikaiViewController: UIViewController,UITextViewDelegate,UITextFieldDelegate{

    @IBOutlet var BoardView: UIView!
    @IBOutlet var nameView: UIView!
    @IBOutlet var nameText: UITextField!
    @IBOutlet var vowView: UIView!
    @IBOutlet var vowText: UITextView!
    @IBOutlet var checkedBtn: UIButton!
    
    @IBOutlet var nextButton: UIButton!
    
    var isChecked = false

    override func viewDidLoad() {
        super.viewDidLoad()
        //遷移先Viewの左上のbackを消す
        let myBackButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = myBackButton
        
        vowText.font = UIFont.systemFont(ofSize: 21)
        
        BoardView.layer.cornerRadius = 40
        nameText.layer.cornerRadius = 40
//        vowText.layer.cornerRadius = 40
        
        nameView.layer.cornerRadius = 20
        vowView.layer.cornerRadius = 40
        
        nameText.delegate = self
        nameText.returnKeyType = .done
        nameText.clearButtonMode = .always
        vowText.delegate = self
        vowText.returnKeyType = .done
//        vowText.clearButtonMode = .always

        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        nameText.resignFirstResponder()
        vowText.resignFirstResponder()
        
    }
    @IBAction func next(_ sender: Any) {
        
        
        if isChecked == false {
            
            let CheckViewController = self.storyboard?.instantiateViewController(withIdentifier: "toCheckVC") as! CheckViewController
            self.navigationController?.pushViewController(CheckViewController, animated: true)
            //遷移先のBox変数に、このコードないの変数Stringを代入する
            
            CheckViewController.name = nameText.text!
            CheckViewController.Chikai = vowText.text!
            
        }else{
            let CheckViewController = self.storyboard?.instantiateViewController(withIdentifier: "toCheckCVC") as! CheckViewController
            self.navigationController?.pushViewController(CheckViewController, animated: true)
            //遷移先のBox変数に、このコードないの変数Stringを代入する
            
            CheckViewController.name = nameText.text!
            CheckViewController.Chikai = vowText.text!
        }
        UserDefaults.standard.set(nameText.text, forKey: "Name")
        UserDefaults.standard.set(vowText.text, forKey: "Message")
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
