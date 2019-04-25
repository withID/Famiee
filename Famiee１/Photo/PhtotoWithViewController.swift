//
//  PhtotoWithViewController.swift
//  Famiee１
//
//  Created by taiki on 2019/04/25.
//  Copyright © 2019 高岸　憲伸. All rights reserved.
//

import UIKit

class PhtotoWithViewController: UIViewController,UITextViewDelegate,UITextFieldDelegate {

    @IBOutlet var name1: UITextField!
    @IBOutlet var name2: UITextField!
    @IBOutlet var checkedBtn: UIButton!
    
    var isChecked = true
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
   
    
    @IBAction func nextBtn(_ sender: Any) {
        
         let PhotocheckViewController = self.storyboard?.instantiateViewController(withIdentifier: "PhotoVC") as! PhotocheckViewController
        
        PhotocheckViewController.name1 = name1.text!
        PhotocheckViewController.name2 = name2.text!
        UserDefaults.standard.set(name1.text, forKey: "name1")
        UserDefaults.standard.set(name2.text, forKey: "name2")
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

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        name1.resignFirstResponder()
        name2.resignFirstResponder()
        
    }

}
