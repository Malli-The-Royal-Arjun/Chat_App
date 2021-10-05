//
//  SocketController.swift
//  Chat App
//
//  Created by Happy on 21/04/21.
//

import UIKit
import SocketIO


struct Mensage {
    var user:String
    var msg:String
}


class SocketController: UIViewController, ObservableObject{
    
    //Manager SocketIO
    let manager = SocketManager(socketURL: URL(string: "http://myalb-4921198.us-east-2.elb.amazonaws.com")!, config: [.log(true), .compress])
    var socket: SocketIOClient!
    
   
    @Published var nameUser : String? = "Arjun"

    
    func join() {
//        self.nameUser = nameUser
        if nameUser != "" {
            if let nameOfUser = self.nameUser {
                self.socket.emitWithAck("join", nameOfUser).timingOut(after: 1) {
                    data in
                    self.performSegue(withIdentifier: "chatMsg", sender: nil)
                }
            }
        } else {
            
        }
    }
    
    //ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        socket = manager.defaultSocket
        socket.on(clientEvent: .connect) { data, ack in print("socket connected") }
        socket.connect()
        
     
    }
    

  

}

class ChatViewController: UIViewController, ObservableObject {
    

    var socket: SocketIOClient!
    var chat = [Mensage]()
    
   
  
    func sendMensage(messageUser: String?){
        guard let msg = messageUser else {return}
        if msg != "" {
            self.socket.emit("send", msg)
          let messageUser = ""
        }
    }
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.socket?.on("chat", callback: { (data, ack) in
            guard let user = data[0] as? String else { return }
            guard let msg = data[1] as? String else { return }
            self.chat = self.chat.reversed()
            self.chat.append(Mensage(user: user, msg: msg))
            self.chat = self.chat.reversed()
//            self.chatTableView.reloadData()
           
    
        })
        
    }
  
    
 
   
}
