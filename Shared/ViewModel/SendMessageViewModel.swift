//
//  SendMessageViewModel.swift
//  Messnger_new
//
//  Created by Алексей Дробный on 14.05.2022.
//

import SwiftUI

class SendMessageViewModel: ObservableObject {
    
    let defaults = UserDefaults.standard
    
    func sendMessage(chatID: String, messageText: String){
        
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        guard let userID = defaults.string(forKey: "userID") else{
            return
        }
        
        LoginWebService().sendMessage(token: token, chatID: chatID, userID: userID, messageText: messageText){ result in
            switch result{
                case .success(let result):
                    print("Message sent")
                case .failure(let result):
                    print("Message not sent")
            }
        }
    }
}
