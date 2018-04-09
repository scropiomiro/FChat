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
            print("請輸入密碼")
        }
        Auth.auth().sendPasswordReset(withEmail: self.emailTxtFld.text!, completion: { (error) in
            // 重設失敗
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            print("重設成功,請檢查信箱郵件")
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
