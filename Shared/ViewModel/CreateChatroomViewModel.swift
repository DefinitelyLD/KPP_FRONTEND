//
//  CreateChatroomViewModel.swift
//  Messnger_new
//
//  Created by Алексей Дробный on 13.05.2022.
//

import SwiftUI

class CreateChatRoomViewModel : ObservableObject {
    
    @Published var chatName: String = ""
    @Published var chatID: String = ""
    
    let defaults = UserDefaults.standard
    
    func createChatroom(){

        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        guard let userID = defaults.string(forKey: "userID") else{
            return
        }
        LoginWebService().createChatroom(token: token, chatName: chatName, userID: userID){ result in
            switch result{
            case .success(let chatID):
                self.defaults.setValue(chatID, forKey: "ChatID")
                print("Decoded")
            case .failure(let response):
                print("Can't decode")
            }
        }
    }
}
