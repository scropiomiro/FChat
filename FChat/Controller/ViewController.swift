//
//  ViewController.swift
//  FChat
//
//  Created by YVTC on 2018/4/9.
//  Copyright © 2018年 YVTC. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onClickLongin(_ sender: Any) {
        if emailTxtFld.text == "" || passwordTxtFld.text == ""{
            let alertController = UIAlertController(title: "提示", message: "請輸入E-mail 與 6個字的密碼", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "確定", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        Auth.auth().signIn(withEmail: emailTxtFld.text!, password: passwordTxtFld.text!){(user,error) in
            if error != nil{
                print((error?.localizedDescription)!)
                let alertController = UIAlertController(title: "提示", message: "請輸入正確的E-mail與密碼", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "確定", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            print("已登入")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatView")
            self.show(vc!, sender: self)
        }
    }
    
    @IBAction func onClickLogout(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            print("登出成功")
            exit(0)
        }catch let error as NSError{
            print((error.localizedDescription))
        }
        
        
    }
    
    @IBAction func onClickRegister(_ sender: Any) {
        emailTxtFld.text = ""
        passwordTxtFld.text = ""
    }
    @IBAction func onClickRest(_ sender: Any) {
        emailTxtFld.text = ""
        passwordTxtFld.text = ""
    }
    
}

