//
//  ResetViewController.swift
//  FChat
//
//  Created by YVTC on 2018/4/9.
//  Copyright © 2018年 YVTC. All rights reserved.
//

import UIKit
import Firebase
class ResetViewController: UIViewController {

    @IBOutlet weak var emailTxtFld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickLogin(_ sender: Any) {
        if emailTxtFld.text == ""{
            let alertController = UIAlertController(title: "提示", message: "請輸6個字的密碼", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "確定", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
        Auth.auth().sendPasswordReset(withEmail: self.emailTxtFld.text!, completion: { (error) in
            // 重設失敗
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            let alertController = UIAlertController(title: "提示", message: "重設成功,請檢查信箱郵件,並重新啟動APP", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "確定", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        })
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
