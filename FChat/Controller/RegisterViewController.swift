//
//  RegisterViewController.swift
//  FChat
//
//  Created by YVTC on 2018/4/9.
//  Copyright © 2018年 YVTC. All rights reserved.
//

import UIKit
import Firebase
class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onClickRegister(_ sender: Any) {
        if emailTxtFld.text == "" || passwordTxtFld.text == ""{
            let alertController = UIAlertController(title: "提示", message: "請輸入E-mail 與 6個字的密碼", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "確定", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        Auth.auth().createUser(withEmail: emailTxtFld.text!, password: passwordTxtFld.text!){(user,error) in
            if error != nil{
                print((error?.localizedDescription)!)
                return
            }
            let alertController = UIAlertController(title: "提示", message: "註冊申請成功", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "確定", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
