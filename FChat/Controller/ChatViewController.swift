//
//  ChatViewController.swift
//  FChat
//
//  Created by YVTC on 2018/4/9.
//  Copyright © 2018年 YVTC. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    var messageArray: [Message] = [Message]()
    
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    @IBOutlet weak var groupLab: UILabel!
    
    var groupValue:String = ""
    var deviceWidth:CGFloat = 0.0
    var deviceHeight:CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let screenSize = UIScreen.main.bounds.size
//        self.view.sizeThatFits(screenSize)
        
        messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTextfield.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tapGesture)
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        configureTableView()
        retrieveMessages()
        messageTableView.separatorStyle = .none
    }
    
    //TableView DataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        
        cell.messageBody.text = messageArray[indexPath.row].messageBody
        cell.senderUsername.text = messageArray[indexPath.row].sender
        cell.timeNow.text = messageArray[indexPath.row].timeNow
        
        return cell
    }
    //TableView DataCount
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    @objc func tableViewTapped() {
        messageTextfield.endEditing(true)
    }
    
    func configureTableView() {
        messageTableView.rowHeight = UITableViewAutomaticDimension
        messageTableView.estimatedRowHeight = 100.0
    }
    
    //Send & Recieve from Firebase
    @IBAction func sendPressed(_ sender: AnyObject) {
        messageTextfield.endEditing(true)
        
        messageTextfield.isEnabled = false
        sendButton.isEnabled = false
        let now = Date()
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        var messageDB = Database.database().reference()
        if groupValue == "" {
            messageDB = Database.database().reference().child("Public")
        }else{
            messageDB = Database.database().reference().child(groupValue)
        }
        
        let messageDictionary = ["Sender": Auth.auth().currentUser?.email, "MessageBody": messageTextfield.text!, "Time": dformatter.string(from: now)]
        
        messageDB.childByAutoId().setValue(messageDictionary) {
            (error, ref) in
            
            if error != nil {
                print(error!)
            } else {
                print("Message saved successfully")
                
                self.messageTextfield.isEnabled = true
                self.sendButton.isEnabled = true
                self.messageTextfield.text = ""
            }
        }
    }

    @IBAction func onClickBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func telPhone(_ sender: Any) {
        let url = URL(string: "tel://0966660613")
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
    
    func retrieveMessages() {
        var messageDB = Database.database().reference()
        if groupValue == "" {
            messageDB = Database.database().reference().child("Public")
            groupLab.text = "Public"
        }else{
            messageDB = Database.database().reference().child(groupValue)
            groupLab.text = groupValue
        }
        
            messageDB.observe(.childAdded) { (snapshot) in
                let snapshotValue = snapshot.value as! Dictionary<String, String>
                
                let text = snapshotValue["MessageBody"]!
                let sender = snapshotValue["Sender"]!
                let time = snapshotValue["Time"]!
                
                let message = Message()
                message.messageBody = text
                message.sender = sender
                message.timeNow = time
                
                self.messageArray.append(message)
                self.configureTableView()
                self.messageTableView.reloadData()
            }
    }
}
