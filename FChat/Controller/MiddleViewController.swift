//
//  MiddleViewController.swift
//  FChat
//
//  Created by YVTC on 2018/4/13.
//  Copyright © 2018年 YVTC. All rights reserved.
//

import UIKit

class MiddleViewController: UIViewController {

    @IBOutlet weak var roomTxtFld: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func backLogin(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginChat(_ sender: Any) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "ChatView") as! ChatViewController
        vc.groupValue = self.roomTxtFld.text!
        self.show(vc, sender: self)
    }
}
