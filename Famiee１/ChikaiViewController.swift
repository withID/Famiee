//
//  ChikaiViewController.swift
//  Famiee１
//
//  Created by 高岸　憲伸 on 2019/03/12.
//  Copyright © 2019 高岸　憲伸. All rights reserved.
//

import UIKit

class ChikaiViewController: UIViewController,UITextFieldDelegate{

    @IBOutlet var BoardView: UIView!
    @IBOutlet var nameView: UIView!
    @IBOutlet var nameText: UITextField!
    @IBOutlet var vowView: UIView!
    @IBOutlet var vowText: UITextField!
    
    @IBOutlet var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        BoardView.layer.cornerRadius = 40
        nameText.layer.cornerRadius = 40
        vowText.layer.cornerRadius = 40
        
        nameView.layer.cornerRadius = 20
        vowView.layer.cornerRadius = 40
        
        nameText.delegate = self
        nameText.returnKeyType = .done
        nameText.clearButtonMode = .always
        vowText.delegate = self
        vowText.returnKeyType = .done
        vowText.clearButtonMode = .always
        
        nameText.delegate = self
        vowText.delegate = self
        

        
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
        
        let CheckViewController = self.storyboard?.instantiateViewController(withIdentifier: "toCheckVC") as! CheckViewController
        
        self.navigationController?.pushViewController(CheckViewController, animated: true)
        //遷移先のBox変数に、このコードないの変数Stringを代入する
        
        CheckViewController.name = nameText.text!
        CheckViewController.Chikai = vowText.text!
 
    }
    
    
    
}
