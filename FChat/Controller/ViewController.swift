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
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func onClickLongin(_ sender: Any) {
        if emailTxtFld.text == "" || passwordTxtFld.text == ""{
            print("請輸入E-mail密碼")
            return
        }
        Auth.auth().signIn(withEmail: emailTxtFld.text!, password: passwordTxtFld.text!){(user,error) in
            if error != nil{
                print((error?.localizedDescription)!)
                return
            }
            print("已登入")
        }
        
    }
    
    @IBAction func onClickLogout(_ sender: Any) {
        if Auth.auth().currentUser == nil {
            print("未登入")
        }
        do{
            try Auth.auth().signOut()
            print("登出成功")
        }catch let error as NSError{
            print((error.localizedDescription))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

