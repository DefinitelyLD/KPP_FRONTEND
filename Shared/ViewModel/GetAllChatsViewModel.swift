//
//  GetAllChatsViewModel.swift
//  Messnger_new
//
//  Created by Алексей Дробный on 14.05.2022.
//

import SwiftUI

class GetAllChatsViewModel: ObservableObject {
    
    var chats: [Chat] = []
    
    let defaults = UserDefaults.standard
    
    func getAllChats(){
        
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        
        LoginWebService().getAllChats(token: token){ result in
            switch result{
                case .success(let result):
                    self.chats = result
                    print(self.chats.count)
                case .failure(let result):
                    print("Chats not recieved")
            }
        }
    }
}
