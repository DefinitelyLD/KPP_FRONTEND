//
//  GetAllMessagesViewModel.swift
//  Messnger_new
//
//  Created by Алексей Дробный on 15.05.2022.
//

import SwiftUI

class GetAllMessagesViewModel: ObservableObject {
    
    var msgs: [ChatMessage] = []
    
    let defaults = UserDefaults.standard
    
    func getAllMessages(chatID: String){
        
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        
        LoginWebService().getAllMessages(token: token, chatID: chatID){ result in
            switch result{
                case .success(let result):
                    self.msgs = result
                    print(self.msgs.count)
                case .failure(let result):
                    print("Chats not recieved")
            }
        }
    }
}

